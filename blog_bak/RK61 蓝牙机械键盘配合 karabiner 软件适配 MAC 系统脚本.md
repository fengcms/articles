title: RK61 蓝牙机械键盘配合 karabiner 软件适配 MAC 系统脚本
date: 2017-10-18 12:06:02 +0800
update: 2017-10-18 12:06:02 +0800
author: fungleo
tags:
    -RK61
    -蓝牙机械键盘
    -mac
    -karabiner
---

# RK61 蓝牙机械键盘配合 karabiner 软件适配 MAC 系统脚本

在 `mac` 升级到 `10.12` 之后，`karabiner` 软件就一直在开发中。以至于我一直都没有使用这个软件来修改键盘映射。最近，我入手了一块 `RK61` 蓝牙机械键盘，准备用在 `mac` 笔记本上。但是默认的键盘布局让我十分恶心，主要是向上的方向键和斜线问号键是集成在一起的。而默认输入的是向上键。那么导致我们在正常操作中输入斜线和问号变得不太顺手。所以，我想要处理一下。

首先是准备刷键盘固件的。和官方联系拿到了固件，但是在刷的过程中出现了问题，一直连接不上。最后放弃，官方虽然可以把键盘邮寄过去重新刷，但是这样就要等好久了，我是个急性子，所以就想到了 `karabiner` 这个软件，去官方网站看了一下，果然新版已经出来了，然后就立即下载下来，准备使用。

当然，你可以自己慢慢配置，但是我已经配置好了，所以，如果你和我使用同样的键盘的话，可以直接使用我的配置哦。

配置文件位置：`~/.config/karabiner/karabiner.json`

主要修改如下：

| 按键 | 输出 | 说明 |
|-|-|-|
|↑|/|对调方向键和斜线的默认设置|
|shift+↑|?|把问号的输入改成正常的|
|fn+↑|↑|向上的方法改成fn组合件，其他的三个方向键是正常的默认的|
|fn+↓|↑|把下箭头的fn组合键改成了向上的箭头，这样可以更方便的输入上箭头|
|shift+esc|~|输入波浪号，去掉了默认键盘需要按 fn 的做法，这样比较符合我们正常的习惯|
|ctrl+esc|`|反正不能直接输入反引号了，默认fn+esc可以输入，但是需要两个手，所以用这个快捷键来代替|

另外，键盘有有线模式和蓝牙模式，所以简单配置的部分，需要些两遍。

你的键盘ID可能和我的不一致，可以先用 `karabiner` 自带的图形工具先简单编辑，得到一个配置文件，然后再在原文件的基础上，进行调整。

配置文件如下：

```json
{
    "global": {
        "check_for_updates_on_startup": true,
        "show_in_menu_bar": true,
        "show_profile_name_in_menu_bar": false
    },
    "profiles": [
        {
            "complex_modifications": {
                "parameters": {
                    "basic.to_if_alone_timeout_milliseconds": 1000
                },
                "rules": [
                    {
                        "description": "适配rk61键盘",
                        "manipulators": [
                            {
                                "from": {
                                    "key_code": "up_arrow",
                                    "modifiers": {
                                        "mandatory": [
                                            "shift"
                                        ],
                                        "optional": [
                                            "caps_lock",
                                            "option"
                                        ]
                                    }
                                },
                                "to": [
                                    {
                                        "key_code": "slash"
                                    }
                                ],
                                "type": "basic"
                            },
                            {
                                "from": {
                                    "key_code": "escape",
                                    "modifiers": {
                                        "mandatory": [
                                            "shift"
                                        ],
                                        "optional": [
                                            "caps_lock",
                                            "option"
                                        ]
                                    }
                                },
                                "to": [
                                    {
                                        "key_code": "grave_accent_and_tilde",
                                        "modifiers": [
                                            "shift"
                                        ]
                                    }
                                ],
                                "type": "basic"
                            },
                            {
                                "from": {
                                    "key_code": "escape",
                                    "modifiers": {
                                        "mandatory": [
                                            "left_control"
                                        ],
                                        "optional": [
                                            "caps_lock",
                                            "option"
                                        ]
                                    }
                                },
                                "to": [
                                    {
                                        "key_code": "grave_accent_and_tilde"
                                    }
                                ],
                                "type": "basic"
                            }
                        ]
                    }
                ]
            },
            "devices": [
                {
                    "disable_built_in_keyboard_if_exists": false,
                    "fn_function_keys": [],
                    "identifiers": {
                        "is_keyboard": true,
                        "is_pointing_device": false,
                        "product_id": 556,
                        "vendor_id": 1452
                    },
                    "ignore": false,
                    "simple_modifications": [
                        {
                            "from": {
                                "key_code": "application"
                            },
                            "to": {
                                "key_code": "up_arrow"
                            }
                        },
                        {
                            "from": {
                                "key_code": "left_command"
                            },
                            "to": {
                                "key_code": "left_option"
                            }
                        },
                        {
                            "from": {
                                "key_code": "left_option"
                            },
                            "to": {
                                "key_code": "left_command"
                            }
                        },
                        {
                            "from": {
                                "key_code": "slash"
                            },
                            "to": {
                                "key_code": "up_arrow"
                            }
                        },
                        {
                            "from": {
                                "key_code": "up_arrow"
                            },
                            "to": {
                                "key_code": "slash"
                            }
                        }
                    ]
                },
                {
                    "disable_built_in_keyboard_if_exists": false,
                    "fn_function_keys": [],
                    "identifiers": {
                        "is_keyboard": true,
                        "is_pointing_device": false,
                        "product_id": 27272,
                        "vendor_id": 9610
                    },
                    "ignore": false,
                    "simple_modifications": [
                        {
                            "from": {
                                "key_code": "application"
                            },
                            "to": {
                                "key_code": "up_arrow"
                            }
                        },
                        {
                            "from": {
                                "key_code": "left_command"
                            },
                            "to": {
                                "key_code": "left_option"
                            }
                        },
                        {
                            "from": {
                                "key_code": "left_option"
                            },
                            "to": {
                                "key_code": "left_command"
                            }
                        },
                        {
                            "from": {
                                "key_code": "slash"
                            },
                            "to": {
                                "key_code": "up_arrow"
                            }
                        },
                        {
                            "from": {
                                "key_code": "up_arrow"
                            },
                            "to": {
                                "key_code": "slash"
                            }
                        }
                    ]
                }
            ],
            "fn_function_keys": [
                {
                    "from": {
                        "key_code": "f1"
                    },
                    "to": {
                        "key_code": "display_brightness_decrement"
                    }
                },
                {
                    "from": {
                        "key_code": "f2"
                    },
                    "to": {
                        "key_code": "display_brightness_increment"
                    }
                },
                {
                    "from": {
                        "key_code": "f3"
                    },
                    "to": {
                        "key_code": "mission_control"
                    }
                },
                {
                    "from": {
                        "key_code": "f4"
                    },
                    "to": {
                        "key_code": "launchpad"
                    }
                },
                {
                    "from": {
                        "key_code": "f5"
                    },
                    "to": {
                        "key_code": "illumination_decrement"
                    }
                },
                {
                    "from": {
                        "key_code": "f6"
                    },
                    "to": {
                        "key_code": "illumination_increment"
                    }
                },
                {
                    "from": {
                        "key_code": "f7"
                    },
                    "to": {
                        "key_code": "rewind"
                    }
                },
                {
                    "from": {
                        "key_code": "f8"
                    },
                    "to": {
                        "key_code": "play_or_pause"
                    }
                },
                {
                    "from": {
                        "key_code": "f9"
                    },
                    "to": {
                        "key_code": "fastforward"
                    }
                },
                {
                    "from": {
                        "key_code": "f10"
                    },
                    "to": {
                        "key_code": "mute"
                    }
                },
                {
                    "from": {
                        "key_code": "f11"
                    },
                    "to": {
                        "key_code": "volume_decrement"
                    }
                },
                {
                    "from": {
                        "key_code": "f12"
                    },
                    "to": {
                        "key_code": "volume_increment"
                    }
                }
            ],
            "name": "Default profile",
            "selected": true,
            "simple_modifications": [],
            "virtual_hid_keyboard": {
                "caps_lock_delay_milliseconds": 0,
                "keyboard_type": "ansi"
            }
        }
    ]
}

```

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。