const std = @import("std");
const expect = std.testing.expect;

pub fn t(a: u8, b: u8) u8 {
    if (a == b) {
        if (a == '0') {
            return '0';
        } else if (a == '1') {
            return '1';
        }
    }
    return '-';
}

pub fn T(ev: []const u8) u8 {
    if (std.mem.eql(u8, ev, "-") or std.mem.eql(u8, ev, "0") or std.mem.eql(u8, ev, "1")) {
        return ev[0];
    } else if (std.mem.eql(u8, ev, "00")) {
        return '0';
    } else if (std.mem.eql(u8, ev, "11")) {
        return '1';
    } else if (std.mem.eql(u8, ev, "01") or std.mem.eql(u8, ev, "10")) {
        return '-';
    } else if ((ev.len == 2) and std.mem.indexOf(u8, ev, "-") != null) {
        return '-';
    } else {
        return t(T(ev[0 .. ev.len / 2]), T(ev[ev.len / 2 .. ev.len]));
    }
}

test "t" {
    try expect(t('0', '0') == '0');
    try expect(t('0', '1') == '-');
    try expect(t('1', '0') == '-');
    try expect(t('1', '1') == '1');
}

test "T" {
    try expect(T("0") == '0');
    try expect(T("1") == '1');
    try expect(T("00") == '0');
    try expect(T("11") == '1');
    try expect(T("01") == '-');
    try expect(T("10") == '-');
    try expect(T("0-") == '-');
    try expect(T("1-") == '-');
    try expect(T("-0") == '-');
    try expect(T("-1") == '-');
}
