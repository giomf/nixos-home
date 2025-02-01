{ pkgs, ... }:

{

  home.packages = with pkgs; [
    bemenu
    gammastep
    swaybg
    sway-contrib.grimshot
    framework-tool
  ];

  wayland.windowManager.hyprland =
    let
      colors = import ./colors.nix;
      focus = colors.purple;
    in
    {
      enable = true;
      extraConfig = ''
                			$mod = SUPER
                			$term = kitty
                			$menu = bemenu-run

                			exec-once = light -N 10
                			exec-once = nm-applet --indicator
                			exec-once = nextcloud --background
                			exec-once = swaybg --mode fill --image ${./wallpaper.png}
        #              exec-once = [workspace 1] telegram-desktop
        #              exec-once = [workspace 1] element-desktop
        #              exec-once = [workspace 5] thunderbird 
                      exec-once = [workspace 9] keepassxc 

                			bind = $mod, return, exec, $term zellij attach -c TERMINAL
                			bind = $mod, space, exec, $menu
                			bind = $mod SHIFT, return, exec, firefox
                			bind = $mod, F, exec, $term yazi
                			bind = $mod, O, exec, keepassxc
                			bind = $mod, M, exec, thunderbird
                			bind = $mod, T, exec, $term -e btop
                			bind = $mod, I, exec, grimshot copy area
                			bind = $mod, C, exec, $term -e numbat
                			bind = $mod, U, exec, bash -c if pgrep gammastep; then pkill gammastep; else gammastep -O 4500; fi
                			bind = $mod, escape, exec, ${pkgs.hyprlock}/bin/hyprlock

                			binde = , XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
                			binde = , XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
                			binde = , XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
                			binde = , XF86MonBrightnessUp, exec, light -A 10
                			binde = , XF86MonBrightnessDown, exec, light -U 10


                			# move focus
                			bind = $mod, H, movefocus, l
                			bind = $mod, L, movefocus, r
                			bind = $mod, K, movefocus, u
                			bind = $mod, J, movefocus, d

                			# move window
                			bind = $mod SHIFT, H, movewindow, l
                			bind = $mod SHIFT, L, movewindow, r
                			bind = $mod SHIFT, K, movewindow, u
                			bind = $mod SHIFT, J, movewindow, d

                			bind = $mod, Q, killactive,
                			bind = $mod, E, fullscreen, 1

                			# workspaces
                			# binds mod + [shift +] {1..10} to [move to] ws {1..10}
                			${
                     builtins.concatStringsSep "\n" (
                       builtins.genList (
                         x:
                         let
                           ws =
                             let
                               c = (x + 1) / 10;
                             in
                             builtins.toString (x + 1 - (c * 10));
                         in
                         ''
                           bind = $mod, ${ws}, workspace, ${toString (x + 1)}
                           bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
                         ''
                       ) 10
                     )
                   }

                			general {
                				border_size = 2
                				gaps_out = 5
                				gaps_in = 5
                				col.active_border = rgb(${focus})
                			}

                			input {
                				kb_layout = de
                			}

                			gestures {
                				workspace_swipe = true
                				workspace_swipe_fingers = 3
                			}

                			misc {
                				disable_hyprland_logo = true
                			}

                			debug {
                    			overlay = false
                			}

                			decoration {
                				shadow { 
                          enabled = false
                        }
                				blur {
                					enabled = false
                				}
                			}

                			monitor=,highres,auto,1.175
                			monitor=DP-2,highres,auto,1

                		'';
    };

  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];
      label = [
        {
          position = "45%, 50%";
          font_size = 60;
          text = "$TIME";
        }
      ];
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = "Password";
          shadow_passes = 2;
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings =

      let
        display_device = " sysfs/backlight/amdgpu_bl1";
        keyboard_device = "sysfs/leds/framework_laptop::kbd_backlight";
      in
      {
        general = {
          lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
          before_sleep_cmd = "${pkgs.hyprlock}/bin/hyprlock";
          after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        };

        listener = [
          # Dimm screen back light
          {
            timeout = 150;
            on-timeout = "${pkgs.light}/bin/light -s ${display_device} -O && ${pkgs.light}/bin/light -s ${display_device} -S 10";
            on-resume = "${pkgs.light}/bin/light -s ${display_device} -I";
          }

          # Turn off keyboard backlight
          {
            timeout = 150;
            on-timeout = "${pkgs.light}/bin/light -s ${keyboard_device} -O && ${pkgs.light}/bin/light -s ${keyboard_device} -S 0";
            on-resume = "${pkgs.light}/bin/light -s ${keyboard_device} -I";
          }

          # Turn off screen backlight
          {
            timeout = 300;
            on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
            on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
          }
          # Lock session
          {
            timeout = 330;
            on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
          }
          # Suspend
          {
            timeout = 600;
            on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];

      };
  };
}
