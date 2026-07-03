#!/usr/bin/env bash
#
# verify.sh — prove a Kestrel release works by compiling and running every
# example in this directory against a real `kestrel` binary.
#
# This is the public stability signal: it exercises the SHIPPED compiler, not
# the source. For each `<name>.kst` with a sibling `<name>.expected`, it runs
# `kestrel run` and checks stdout (and the optional `<name>.exitcode`, default
# 0). Every file under `compile-fail/` must FAIL `kestrel check` with stderr
# containing its `.expected` substring.
#
# Usage:
#   KESTREL=/path/to/kestrel ./verify.sh
#   ./verify.sh                       # uses `kestrel` from PATH
#
# Needs the same toolchain as the compiler: `llc` (LLVM) and `cc`.
set -uo pipefail

KESTREL="${KESTREL:-kestrel}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pass=0
fail=0
failed_names=()

note()  { printf '%s\n' "$*"; }
green() { printf '\033[32m%s\033[0m\n' "$*"; }
red()   { printf '\033[31m%s\033[0m\n' "$*"; }

require() {
  command -v "$1" >/dev/null 2>&1 || { red "missing required tool: $1"; exit 2; }
}
require "$KESTREL"
require llc
require cc

run_case() {
  local kst="$1"
  local name expected exitcode_file want_code
  name="$(basename "$kst" .kst)"
  expected="${kst%.kst}.expected"
  exitcode_file="${kst%.kst}.exitcode"
  [ -f "$expected" ] || return 0   # only assert files that declare expected output
  want_code=0
  [ -f "$exitcode_file" ] && want_code="$(tr -d '[:space:]' < "$exitcode_file")"

  # Work in a temp dir so intermediate .ll/.o/binary never touch the tree.
  local tmp; tmp="$(mktemp -d)"
  cp "$kst" "$tmp/"
  local out code
  out="$("$KESTREL" run "$tmp/$name.kst" 2>"$tmp/stderr")"
  code=$?
  rm -rf "$tmp"

  if [ "$out" == "$(cat "$expected")" ] && [ "$code" -eq "$want_code" ]; then
    green "  PASS  $name"
    pass=$((pass + 1))
  else
    red   "  FAIL  $name (exit $code, wanted $want_code)"
    failed_names+=("$name")
    fail=$((fail + 1))
  fi
}

run_compile_fail() {
  local kst="$1"
  local name expected
  name="$(basename "$kst" .kst)"
  expected="${kst%.kst}.expected"
  [ -f "$expected" ] || return 0
  local err
  err="$("$KESTREL" check "$kst" 2>&1)"
  if [ $? -ne 0 ] && grep -qF "$(cat "$expected")" <<<"$err"; then
    green "  PASS  compile-fail/$name"
    pass=$((pass + 1))
  else
    red   "  FAIL  compile-fail/$name (expected rejection matching '$(cat "$expected")')"
    failed_names+=("compile-fail/$name")
    fail=$((fail + 1))
  fi
}

note "Verifying '$($KESTREL version 2>/dev/null | tail -1)' against $HERE"
note "== run + assert output =="
for kst in "$HERE"/*.kst; do
  [ -e "$kst" ] || continue
  run_case "$kst"
done

note "== compile-fail (must be rejected) =="
for kst in "$HERE"/compile-fail/*.kst; do
  [ -e "$kst" ] || continue
  run_compile_fail "$kst"
done

note ""
if [ "$fail" -eq 0 ]; then
  green "All $pass checks passed."
  exit 0
else
  red "$fail of $((pass + fail)) checks failed: ${failed_names[*]}"
  exit 1
fi
