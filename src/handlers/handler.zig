const zap = @import("zap");
const std = @import("std");

const Resp = struct { status_code: u32, status_message: []const u8 };

pub fn on_request(r: zap.Request) void {
    if (r.path) |the_path| {
        std.debug.print("PATH: {s}\n", .{the_path});
    }

    if (r.query) |the_query| {
        std.debug.print("QUERY: {s}\n", .{the_query});
    }

    var json_resp: []const u8 = undefined;
    const resp = Resp{ .status_code = 200, .status_message = "ok" };
    var buf: [100]u8 = undefined;
    if (zap.stringifyBuf(&buf, resp, .{})) |json| {
        json_resp = json;
    } else {
        json_resp = "null";
    }

    r.sendJson(json_resp) catch return;
}
