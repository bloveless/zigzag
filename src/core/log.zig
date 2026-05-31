//! Debug file logging for ZigZag applications.
//! Since stdout is owned by the renderer, this provides file-based logging.

const std = @import("std");

/// Logger that writes timestamped messages to a file
pub const Logger = struct {
    io: std.Io,
    file: std.Io.File,
    writer: std.Io.Writer,
    mutex: std.Io.Mutex,

    /// Initialize a logger that writes to the given file path
    pub fn init(io: std.Io, path: []const u8) !Logger {
        const file = try std.Io.Dir.cwd().createFile(io, path, .{ .truncate = false });
        var writer_buffer: [1024]u8 = undefined;
        var file_writer = file.writer(io, &writer_buffer);
        try file_writer.end();
        return .{
            .io = io,
            .file = file,
            .writer = file_writer.interface,
            .mutex = .init,
        };
    }

    /// Close the log file
    pub fn deinit(self: *Logger) void {
        self.writer.flush();
        self.file.close();
    }

    /// Write a log message with timestamp prefix
    pub fn log(self: *Logger, comptime fmt: []const u8, args: anytype) void {
        self.mutex.lock();
        defer self.mutex.unlock();

        // Write timestamp
        const now = std.time.timestamp();
        const epoch_seconds = std.time.epoch.EpochSeconds{ .secs = @intCast(now) };
        const day_seconds = epoch_seconds.getDaySeconds();

        self.writer.print("[{d:0>2}:{d:0>2}:{d:0>2}] ", .{
            day_seconds.getHoursIntoDay(),
            day_seconds.getMinutesIntoHour(),
            day_seconds.getSecondsIntoMinute(),
        }) catch return;

        // Write message
        self.writer.print(fmt, args) catch return;
        self.writer.writeByte('\n') catch return;
    }
};
