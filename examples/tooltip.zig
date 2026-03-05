//! ZigZag Tooltip Example
//! Demonstrates the Tooltip component with different placements and presets.
//!
//! Keys:
//!   1-4 — Show tooltip with different placements (bottom/top/right/left)
//!   5   — Show titled tooltip
//!   6   — Show help-style tooltip
//!   7   — Show shortcut tooltip
//!   h   — Hide tooltip
//!   q   — Quit

const std = @import("std");
const zz = @import("zigzag");

const Model = struct {
    tooltip: zz.Tooltip,
    status: []const u8,

    pub const Msg = union(enum) {
        key: zz.KeyEvent,
    };

    pub fn init(self: *Model, _: *zz.Context) zz.Cmd(Msg) {
        self.tooltip = zz.Tooltip.init("This is a tooltip!");
        self.status = "Press 1-7 to show tooltips, h to hide, q to quit";
        return .none;
    }

    pub fn update(self: *Model, m: Msg, _: *zz.Context) zz.Cmd(Msg) {
        switch (m) {
            .key => |k| {
                switch (k.key) {
                    .char => |c| switch (c) {
                        'q' => return .quit,
                        '1' => {
                            self.tooltip = zz.Tooltip.init("Bottom placement tooltip");
                            self.tooltip.target_x = 20;
                            self.tooltip.target_y = 5;
                            self.tooltip.target_width = 6;
                            self.tooltip.placement = .bottom;
                            self.tooltip.show();
                            self.status = "Showing: bottom placement";
                        },
                        '2' => {
                            self.tooltip = zz.Tooltip.init("Top placement tooltip");
                            self.tooltip.target_x = 20;
                            self.tooltip.target_y = 12;
                            self.tooltip.target_width = 6;
                            self.tooltip.placement = .top;
                            self.tooltip.show();
                            self.status = "Showing: top placement";
                        },
                        '3' => {
                            self.tooltip = zz.Tooltip.init("Right placement");
                            self.tooltip.target_x = 10;
                            self.tooltip.target_y = 8;
                            self.tooltip.target_width = 6;
                            self.tooltip.placement = .right;
                            self.tooltip.show();
                            self.status = "Showing: right placement";
                        },
                        '4' => {
                            self.tooltip = zz.Tooltip.init("Left placement");
                            self.tooltip.target_x = 50;
                            self.tooltip.target_y = 8;
                            self.tooltip.target_width = 6;
                            self.tooltip.placement = .left;
                            self.tooltip.show();
                            self.status = "Showing: left placement";
                        },
                        '5' => {
                            self.tooltip = zz.Tooltip.titled("File Info", "Size: 1.2 MB\nModified: Today\nType: Document");
                            self.tooltip.target_x = 20;
                            self.tooltip.target_y = 5;
                            self.tooltip.target_width = 8;
                            self.tooltip.show();
                            self.status = "Showing: titled tooltip";
                        },
                        '6' => {
                            self.tooltip = zz.Tooltip.help("Press Enter to confirm your selection");
                            self.tooltip.target_x = 20;
                            self.tooltip.target_y = 5;
                            self.tooltip.target_width = 10;
                            self.tooltip.show();
                            self.status = "Showing: help-style tooltip";
                        },
                        '7' => {
                            self.tooltip = zz.Tooltip.shortcut("Save", "Ctrl+S");
                            self.tooltip.target_x = 20;
                            self.tooltip.target_y = 5;
                            self.tooltip.target_width = 4;
                            self.tooltip.show();
                            self.status = "Showing: shortcut tooltip";
                        },
                        'h' => {
                            self.tooltip.hide();
                            self.status = "Tooltip hidden";
                        },
                        else => {},
                    },
                    .escape => return .quit,
                    else => {},
                }
            },
        }
        return .none;
    }

    pub fn view(self: *const Model, ctx: *const zz.Context) []const u8 {
        const alloc = ctx.allocator;

        // Build a base view
        var title_s = zz.Style{};
        title_s = title_s.bold(true).fg(zz.Color.hex("#FF6B6B")).inline_style(true);

        var hint_s = zz.Style{};
        hint_s = hint_s.fg(zz.Color.gray(14)).inline_style(true);

        var status_s = zz.Style{};
        status_s = status_s.fg(zz.Color.gray(12)).inline_style(true);

        const title = title_s.render(alloc, "Tooltip Component Demo") catch "Tooltip Component Demo";
        const hint = hint_s.render(alloc, "1-4: Placements  5: Titled  6: Help  7: Shortcut  h: Hide  q: Quit") catch "";
        const status = status_s.render(alloc, self.status) catch "";

        const content = std.fmt.allocPrint(alloc, "{s}\n\n{s}\n\n{s}", .{
            title, hint, status,
        }) catch "Error";

        const base = zz.place.place(alloc, ctx.width, ctx.height, .center, .middle, content) catch content;

        // Overlay tooltip if visible
        if (self.tooltip.isVisible()) {
            return self.tooltip.overlay(alloc, base, ctx.width, ctx.height) catch base;
        }

        return base;
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var prog = try zz.Program(Model).init(gpa.allocator());
    defer prog.deinit();

    try prog.run();
}
