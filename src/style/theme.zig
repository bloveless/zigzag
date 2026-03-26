//! Theming system for ZigZag.
//! Provides centralized color palettes and component-specific themes.

const Color = @import("color.zig").Color;
const style_mod = @import("style.zig");

/// Semantic color palette. Defines named colors for a theme.
pub const Palette = struct {
    // Primary colors
    primary: Color,
    secondary: Color,
    accent: Color,

    // Surfaces
    background: Color,
    surface: Color,
    overlay: Color,

    // Text
    foreground: Color,
    muted: Color,
    subtle: Color,

    // Feedback
    success: Color,
    warning: Color,
    danger: Color,
    info: Color,

    // Borders
    border_color: Color,
    border_focus: Color,

    // Highlight
    highlight: Color,
    highlight_text: Color,

    // ── Built-in presets ──────────────────────────────

    pub const default_dark = Palette{
        .primary = Color.cyan(),
        .secondary = Color.magenta(),
        .accent = Color.yellow(),
        .background = Color.fromRgb(24, 24, 32),
        .surface = Color.fromRgb(32, 32, 42),
        .overlay = Color.fromRgb(40, 40, 52),
        .foreground = Color.white(),
        .muted = Color.gray(14),
        .subtle = Color.gray(10),
        .success = Color.green(),
        .warning = Color.yellow(),
        .danger = Color.red(),
        .info = Color.cyan(),
        .border_color = Color.gray(12),
        .border_focus = Color.cyan(),
        .highlight = Color.fromRgb(60, 60, 80),
        .highlight_text = Color.white(),
    };

    pub const default_light = Palette{
        .primary = Color.fromRgb(0, 120, 180),
        .secondary = Color.fromRgb(140, 60, 160),
        .accent = Color.fromRgb(180, 120, 0),
        .background = Color.fromRgb(250, 250, 250),
        .surface = Color.fromRgb(240, 240, 240),
        .overlay = Color.fromRgb(230, 230, 230),
        .foreground = Color.fromRgb(30, 30, 30),
        .muted = Color.fromRgb(100, 100, 100),
        .subtle = Color.fromRgb(160, 160, 160),
        .success = Color.fromRgb(40, 160, 40),
        .warning = Color.fromRgb(200, 150, 0),
        .danger = Color.fromRgb(200, 40, 40),
        .info = Color.fromRgb(0, 120, 180),
        .border_color = Color.fromRgb(180, 180, 180),
        .border_focus = Color.fromRgb(0, 120, 180),
        .highlight = Color.fromRgb(200, 220, 240),
        .highlight_text = Color.fromRgb(30, 30, 30),
    };

    pub const catppuccin_mocha = Palette{
        .primary = Color.fromRgb(137, 180, 250), // blue
        .secondary = Color.fromRgb(203, 166, 247), // mauve
        .accent = Color.fromRgb(249, 226, 175), // yellow
        .background = Color.fromRgb(30, 30, 46), // base
        .surface = Color.fromRgb(49, 50, 68), // surface0
        .overlay = Color.fromRgb(69, 71, 90), // surface1
        .foreground = Color.fromRgb(205, 214, 244), // text
        .muted = Color.fromRgb(166, 173, 200), // subtext0
        .subtle = Color.fromRgb(127, 132, 156), // overlay1
        .success = Color.fromRgb(166, 227, 161), // green
        .warning = Color.fromRgb(249, 226, 175), // yellow
        .danger = Color.fromRgb(243, 139, 168), // red
        .info = Color.fromRgb(137, 180, 250), // blue
        .border_color = Color.fromRgb(88, 91, 112), // overlay0
        .border_focus = Color.fromRgb(137, 180, 250), // blue
        .highlight = Color.fromRgb(49, 50, 68), // surface0
        .highlight_text = Color.fromRgb(205, 214, 244), // text
    };

    pub const catppuccin_latte = Palette{
        .primary = Color.fromRgb(30, 102, 245), // blue
        .secondary = Color.fromRgb(136, 57, 239), // mauve
        .accent = Color.fromRgb(223, 142, 29), // yellow
        .background = Color.fromRgb(239, 241, 245), // base
        .surface = Color.fromRgb(204, 208, 218), // surface0
        .overlay = Color.fromRgb(188, 192, 204), // surface1
        .foreground = Color.fromRgb(76, 79, 105), // text
        .muted = Color.fromRgb(108, 111, 133), // subtext0
        .subtle = Color.fromRgb(140, 143, 161), // overlay1
        .success = Color.fromRgb(64, 160, 43), // green
        .warning = Color.fromRgb(223, 142, 29), // yellow
        .danger = Color.fromRgb(210, 15, 57), // red
        .info = Color.fromRgb(30, 102, 245), // blue
        .border_color = Color.fromRgb(156, 160, 176), // overlay0
        .border_focus = Color.fromRgb(30, 102, 245), // blue
        .highlight = Color.fromRgb(204, 208, 218), // surface0
        .highlight_text = Color.fromRgb(76, 79, 105), // text
    };

    pub const dracula = Palette{
        .primary = Color.fromRgb(189, 147, 249), // purple
        .secondary = Color.fromRgb(255, 121, 198), // pink
        .accent = Color.fromRgb(241, 250, 140), // yellow
        .background = Color.fromRgb(40, 42, 54), // background
        .surface = Color.fromRgb(68, 71, 90), // current line
        .overlay = Color.fromRgb(68, 71, 90), // current line
        .foreground = Color.fromRgb(248, 248, 242), // foreground
        .muted = Color.fromRgb(98, 114, 164), // comment
        .subtle = Color.fromRgb(98, 114, 164), // comment
        .success = Color.fromRgb(80, 250, 123), // green
        .warning = Color.fromRgb(255, 184, 108), // orange
        .danger = Color.fromRgb(255, 85, 85), // red
        .info = Color.fromRgb(139, 233, 253), // cyan
        .border_color = Color.fromRgb(98, 114, 164), // comment
        .border_focus = Color.fromRgb(189, 147, 249), // purple
        .highlight = Color.fromRgb(68, 71, 90), // current line
        .highlight_text = Color.fromRgb(248, 248, 242), // foreground
    };

    pub const nord = Palette{
        .primary = Color.fromRgb(136, 192, 208), // nord8 frost
        .secondary = Color.fromRgb(129, 161, 193), // nord9
        .accent = Color.fromRgb(235, 203, 139), // nord13 aurora yellow
        .background = Color.fromRgb(46, 52, 64), // nord0 polar night
        .surface = Color.fromRgb(59, 66, 82), // nord1
        .overlay = Color.fromRgb(67, 76, 94), // nord2
        .foreground = Color.fromRgb(236, 239, 244), // nord6 snow storm
        .muted = Color.fromRgb(216, 222, 233), // nord4
        .subtle = Color.fromRgb(76, 86, 106), // nord3
        .success = Color.fromRgb(163, 190, 140), // nord14 aurora green
        .warning = Color.fromRgb(235, 203, 139), // nord13
        .danger = Color.fromRgb(191, 97, 106), // nord11 aurora red
        .info = Color.fromRgb(136, 192, 208), // nord8
        .border_color = Color.fromRgb(76, 86, 106), // nord3
        .border_focus = Color.fromRgb(136, 192, 208), // nord8
        .highlight = Color.fromRgb(59, 66, 82), // nord1
        .highlight_text = Color.fromRgb(236, 239, 244), // nord6
    };

    pub const high_contrast = Palette{
        .primary = Color.fromRgb(0, 200, 255),
        .secondary = Color.fromRgb(255, 100, 255),
        .accent = Color.fromRgb(255, 255, 0),
        .background = Color.fromRgb(0, 0, 0),
        .surface = Color.fromRgb(20, 20, 20),
        .overlay = Color.fromRgb(40, 40, 40),
        .foreground = Color.fromRgb(255, 255, 255),
        .muted = Color.fromRgb(200, 200, 200),
        .subtle = Color.fromRgb(150, 150, 150),
        .success = Color.fromRgb(0, 255, 0),
        .warning = Color.fromRgb(255, 255, 0),
        .danger = Color.fromRgb(255, 0, 0),
        .info = Color.fromRgb(0, 200, 255),
        .border_color = Color.fromRgb(200, 200, 200),
        .border_focus = Color.fromRgb(0, 200, 255),
        .highlight = Color.fromRgb(0, 80, 120),
        .highlight_text = Color.fromRgb(255, 255, 255),
    };

    pub const tokyo_night = Palette{
        .primary = Color.fromRgb(122, 162, 247), // blue
        .secondary = Color.fromRgb(187, 154, 247), // purple
        .accent = Color.fromRgb(224, 175, 104), // yellow
        .background = Color.fromRgb(26, 27, 38), // bg
        .surface = Color.fromRgb(36, 40, 59), // bg_highlight
        .overlay = Color.fromRgb(41, 46, 66), // terminal_black
        .foreground = Color.fromRgb(192, 202, 245), // fg
        .muted = Color.fromRgb(144, 153, 191), // comment
        .subtle = Color.fromRgb(86, 95, 137), // dark5
        .success = Color.fromRgb(158, 206, 106), // green
        .warning = Color.fromRgb(224, 175, 104), // yellow
        .danger = Color.fromRgb(247, 118, 142), // red
        .info = Color.fromRgb(125, 207, 255), // cyan
        .border_color = Color.fromRgb(41, 46, 66),
        .border_focus = Color.fromRgb(122, 162, 247),
        .highlight = Color.fromRgb(41, 46, 66),
        .highlight_text = Color.fromRgb(192, 202, 245),
    };

    pub const gruvbox_dark = Palette{
        .primary = Color.fromRgb(131, 165, 152), // aqua
        .secondary = Color.fromRgb(211, 134, 155), // purple
        .accent = Color.fromRgb(250, 189, 47), // yellow
        .background = Color.fromRgb(40, 40, 40), // bg
        .surface = Color.fromRgb(60, 56, 54), // bg1
        .overlay = Color.fromRgb(80, 73, 69), // bg2
        .foreground = Color.fromRgb(235, 219, 178), // fg
        .muted = Color.fromRgb(168, 153, 132), // gray
        .subtle = Color.fromRgb(124, 111, 100), // bg4
        .success = Color.fromRgb(184, 187, 38), // green
        .warning = Color.fromRgb(250, 189, 47), // yellow
        .danger = Color.fromRgb(251, 73, 52), // red
        .info = Color.fromRgb(131, 165, 152), // aqua
        .border_color = Color.fromRgb(80, 73, 69),
        .border_focus = Color.fromRgb(131, 165, 152),
        .highlight = Color.fromRgb(80, 73, 69),
        .highlight_text = Color.fromRgb(235, 219, 178),
    };

    pub const solarized_dark = Palette{
        .primary = Color.fromRgb(38, 139, 210), // blue
        .secondary = Color.fromRgb(108, 113, 196), // violet
        .accent = Color.fromRgb(181, 137, 0), // yellow
        .background = Color.fromRgb(0, 43, 54), // base03
        .surface = Color.fromRgb(7, 54, 66), // base02
        .overlay = Color.fromRgb(88, 110, 117), // base01
        .foreground = Color.fromRgb(131, 148, 150), // base0
        .muted = Color.fromRgb(101, 123, 131), // base00
        .subtle = Color.fromRgb(88, 110, 117), // base01
        .success = Color.fromRgb(133, 153, 0), // green
        .warning = Color.fromRgb(181, 137, 0), // yellow
        .danger = Color.fromRgb(220, 50, 47), // red
        .info = Color.fromRgb(42, 161, 152), // cyan
        .border_color = Color.fromRgb(88, 110, 117),
        .border_focus = Color.fromRgb(38, 139, 210),
        .highlight = Color.fromRgb(7, 54, 66),
        .highlight_text = Color.fromRgb(147, 161, 161),
    };

    pub const solarized_light = Palette{
        .primary = Color.fromRgb(38, 139, 210), // blue
        .secondary = Color.fromRgb(108, 113, 196), // violet
        .accent = Color.fromRgb(181, 137, 0), // yellow
        .background = Color.fromRgb(253, 246, 227), // base3
        .surface = Color.fromRgb(238, 232, 213), // base2
        .overlay = Color.fromRgb(147, 161, 161), // base1
        .foreground = Color.fromRgb(101, 123, 131), // base00
        .muted = Color.fromRgb(131, 148, 150), // base0
        .subtle = Color.fromRgb(147, 161, 161), // base1
        .success = Color.fromRgb(133, 153, 0), // green
        .warning = Color.fromRgb(181, 137, 0), // yellow
        .danger = Color.fromRgb(220, 50, 47), // red
        .info = Color.fromRgb(42, 161, 152), // cyan
        .border_color = Color.fromRgb(147, 161, 161),
        .border_focus = Color.fromRgb(38, 139, 210),
        .highlight = Color.fromRgb(238, 232, 213),
        .highlight_text = Color.fromRgb(88, 110, 117),
    };

    /// List of all built-in palette names for iteration.
    pub const builtins = [_]struct { name: []const u8, palette: Palette }{
        .{ .name = "Default Dark", .palette = default_dark },
        .{ .name = "Default Light", .palette = default_light },
        .{ .name = "Catppuccin Mocha", .palette = catppuccin_mocha },
        .{ .name = "Catppuccin Latte", .palette = catppuccin_latte },
        .{ .name = "Dracula", .palette = dracula },
        .{ .name = "Nord", .palette = nord },
        .{ .name = "Tokyo Night", .palette = tokyo_night },
        .{ .name = "Gruvbox Dark", .palette = gruvbox_dark },
        .{ .name = "Solarized Dark", .palette = solarized_dark },
        .{ .name = "Solarized Light", .palette = solarized_light },
        .{ .name = "High Contrast", .palette = high_contrast },
    };
};

/// Adaptive palette that resolves based on dark/light background.
pub const AdaptivePalette = struct {
    light: Palette,
    dark: Palette,

    pub fn resolve(self: AdaptivePalette, is_dark: bool) Palette {
        return if (is_dark) self.dark else self.light;
    }

    pub const catppuccin = AdaptivePalette{
        .light = Palette.catppuccin_latte,
        .dark = Palette.catppuccin_mocha,
    };

    pub const default = AdaptivePalette{
        .light = Palette.default_light,
        .dark = Palette.default_dark,
    };

    pub const solarized = AdaptivePalette{
        .light = Palette.solarized_light,
        .dark = Palette.solarized_dark,
    };
};

/// Manages the active theme at runtime.
/// Holds a current theme and provides methods to switch between palettes.
pub const ThemeManager = struct {
    current: Theme,
    is_dark: bool,
    palette_index: usize,

    /// Initialize with auto-detected dark/light background.
    pub fn init() ThemeManager {
        const is_dark = @import("color.zig").hasDarkBackground();
        const palette = AdaptivePalette.default.resolve(is_dark);
        return .{
            .current = Theme.fromPalette(palette),
            .is_dark = is_dark,
            .palette_index = 0,
        };
    }

    /// Initialize with a specific palette.
    pub fn initWithPalette(palette: Palette) ThemeManager {
        const is_dark = @import("color.zig").hasDarkBackground();
        return .{
            .current = Theme.fromPalette(palette),
            .is_dark = is_dark,
            .palette_index = 0,
        };
    }

    /// Switch to a specific palette.
    pub fn setPalette(self: *ThemeManager, palette: Palette) void {
        self.current = Theme.fromPalette(palette);
    }

    /// Switch to a named built-in palette by index.
    pub fn setBuiltinByIndex(self: *ThemeManager, index: usize) void {
        if (index < Palette.builtins.len) {
            self.palette_index = index;
            self.current = Theme.fromPalette(Palette.builtins[index].palette);
        }
    }

    /// Cycle to the next built-in palette.
    pub fn nextBuiltin(self: *ThemeManager) void {
        self.palette_index = (self.palette_index + 1) % Palette.builtins.len;
        self.current = Theme.fromPalette(Palette.builtins[self.palette_index].palette);
    }

    /// Cycle to the previous built-in palette.
    pub fn prevBuiltin(self: *ThemeManager) void {
        self.palette_index = if (self.palette_index == 0) Palette.builtins.len - 1 else self.palette_index - 1;
        self.current = Theme.fromPalette(Palette.builtins[self.palette_index].palette);
    }

    /// Get the name of the current built-in palette.
    pub fn currentName(self: *const ThemeManager) []const u8 {
        return Palette.builtins[self.palette_index].name;
    }

    /// Get the total number of built-in palettes.
    pub fn builtinCount() usize {
        return Palette.builtins.len;
    }
};

/// Theme contains a palette and derived component styles.
pub const Theme = struct {
    palette: Palette,

    // Derived styles for components
    text: TextTheme,
    list: ListTheme,
    progress: ProgressTheme,
    modal: ModalTheme,
    notification: NotificationTheme,
    tab: TabTheme,

    pub const TextTheme = struct {
        text_fg: Color,
        placeholder_fg: Color,
        prompt_fg: Color,
        border_fg: Color,
        border_focus_fg: Color,
    };

    pub const ListTheme = struct {
        item_fg: Color,
        selected_fg: Color,
        cursor_fg: Color,
        filter_fg: Color,
    };

    pub const ProgressTheme = struct {
        filled_fg: Color,
        empty_fg: Color,
        percent_fg: Color,
    };

    pub const ModalTheme = struct {
        border_fg: Color,
        title_fg: Color,
        body_fg: Color,
        button_fg: Color,
        button_active_bg: Color,
    };

    pub const NotificationTheme = struct {
        info_fg: Color,
        success_fg: Color,
        warning_fg: Color,
        err_fg: Color,
    };

    pub const TabTheme = struct {
        bar_fg: Color,
        active_fg: Color,
        active_bg: Color,
        inactive_fg: Color,
    };

    /// Create a Theme from a Palette with sensible defaults.
    pub fn fromPalette(p: Palette) Theme {
        return .{
            .palette = p,
            .text = .{
                .text_fg = p.foreground,
                .placeholder_fg = p.subtle,
                .prompt_fg = p.primary,
                .border_fg = p.border_color,
                .border_focus_fg = p.border_focus,
            },
            .list = .{
                .item_fg = p.foreground,
                .selected_fg = p.primary,
                .cursor_fg = p.secondary,
                .filter_fg = p.accent,
            },
            .progress = .{
                .filled_fg = p.primary,
                .empty_fg = p.subtle,
                .percent_fg = p.foreground,
            },
            .modal = .{
                .border_fg = p.border_color,
                .title_fg = p.foreground,
                .body_fg = p.muted,
                .button_fg = p.foreground,
                .button_active_bg = p.primary,
            },
            .notification = .{
                .info_fg = p.info,
                .success_fg = p.success,
                .warning_fg = p.warning,
                .err_fg = p.danger,
            },
            .tab = .{
                .bar_fg = p.muted,
                .active_fg = p.foreground,
                .active_bg = p.primary,
                .inactive_fg = p.subtle,
            },
        };
    }

    /// Helper to create a Style with foreground color from the theme.
    pub fn styleWith(fg: Color) style_mod.Style {
        var s = style_mod.Style{};
        s = s.fg(fg);
        s = s.inline_style(true);
        return s;
    }

    /// Helper to create a bold Style with foreground color.
    pub fn boldStyleWith(fg: Color) style_mod.Style {
        var s = style_mod.Style{};
        s = s.fg(fg);
        s = s.bold(true);
        s = s.inline_style(true);
        return s;
    }
};
