const zap = @import("zap");
const std = @import("std");

const Resp = struct { status_code: u8, status_message: []const u8 };

fn generate_response(allocator: std.mem.Allocator) []const u8 {
    const resp = Resp{ .status_code = 200, .status_message = "ok" };
    var buf: [100]u8 = undefined;
    if (zap.stringifyBuf(&buf, resp, .{})) |json| {
        if (allocator.dupe(u8, json)) |json_resp| {
            return json_resp;
        } else |_| {
            return "Error";
        }
    }
    return "Error";
}

pub fn on_request(r: zap.Request) void {
    if (r.path) |the_path| {
        std.debug.print("PATH: {s}\n", .{the_path});
    }

    if (r.query) |the_query| {
        std.debug.print("QUERY: {s}\n", .{the_query});
    }
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const json_res = generate_response(allocator);
    defer allocator.free(json_res);

    r.sendJson(json_res) catch return;
}

test "test resonse" {}
