goog.provide('Blockly.Msg.ja.smalruby');

goog.require('Blockly.Msg');


/**
 * Due to the frequency of long strings, the 80-column wrap rule need not apply
 * to message files.
 */

// views/main_menu_view.js.coffee
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_COMMON_LINES = '行';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_COMMON_LETTERS = '文字';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_COMMON_COMMA = '、';


Blockly.Msg.VIEWS_MAIN_MENU_VIEW_RUN_BLOCKUI_TITLE = 'プログラムの実行中';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_RUN_BLOCKUI_MESSAGE = 'プログラムの画面に切り替えてください。';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_RUN_BLOCKUI_NOTICE = 'プログラムをセーブ・チェックしてから実行するよ♪<br>Escキーを押すとプログラムが終わります。';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_RUN_ERROR_CANT_RUN = 'プログラムを実行できませんでした';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_RUN_ERROR_CANCEL_TO_RUN = 'プログラムの実行をキャンセルしました';

// blocks/motion.js.coffee.erb
Blockly.Msg.BLOCKS_MOTION_MOVE = '%1歩動かす';
Blockly.Msg.BLOCKS_MOTION_TURN_RIGHT_DEGREES = '時計回りに%1度回す';
Blockly.Msg.BLOCKS_MOTION_TURN_LEFT_DEGREES = '反時計回りに%1度回す';
Blockly.Msg.BLOCKS_MOTION_POINT_IN_DIRECTION = '%1度に向ける';
Blockly.Msg.BLOCKS_MOTION_POINT_TOWARDS_MOUSE = 'マウスポインターへ向ける';
Blockly.Msg.BLOCKS_MOTION_POINT_TOWARDS_CHARACTER = 'へ向ける';
Blockly.Msg.BLOCKS_MOTION_SET_X_Y_X = 'x座標を';
Blockly.Msg.BLOCKS_MOTION_SET_X_Y_Y = '、y座標を';
Blockly.Msg.BLOCKS_MOTION_SET_X_Y_SUFFIX = 'にする';
Blockly.Msg.BLOCKS_MOTION_GO_TO_MOUSE = 'マウスポインターへ行く';
Blockly.Msg.BLOCKS_MOTION_GO_TO_CHARACTER_PREFIX = '';
Blockly.Msg.BLOCKS_MOTION_GO_TO_CHARACTER_SUFFIX = 'へ行く';
Blockly.Msg.BLOCKS_MOTION_CHANGE_X_BY = 'x座標を%1ずつ変える';
Blockly.Msg.BLOCKS_MOTION_SET_X = 'x座標を%1にする';
Blockly.Msg.BLOCKS_MOTION_CHANGE_Y_BY = 'y座標を%1ずつ変える';
Blockly.Msg.BLOCKS_MOTION_SET_Y = 'y座標を%1にする';
Blockly.Msg.BLOCKS_MOTION_TURN_IF_REACH_WALL = 'もし端に着いたら、跳ね返る';
Blockly.Msg.BLOCKS_MOTION_TURN = '跳ね返る';
Blockly.Msg.BLOCKS_MOTION_TURN_XY_X = '水平(x)';
Blockly.Msg.BLOCKS_MOTION_TURN_XY_Y = '垂直(y)';
Blockly.Msg.BLOCKS_MOTION_TURN_XY_PREFIX = '';
Blockly.Msg.BLOCKS_MOTION_TURN_XY_SUFFIX = '方向に跳ね返る';
Blockly.Msg.BLOCKS_MOTION_SET_ROTATION_STYLE_LEFT_RIGHT = '左右のみ';
Blockly.Msg.BLOCKS_MOTION_SET_ROTATION_STYLE_NONE = '回転しない';
Blockly.Msg.BLOCKS_MOTION_SET_ROTATION_STYLE_FREE = '自由に回転';
Blockly.Msg.BLOCKS_MOTION_SET_ROTATION_STYLE_PREFIX = '回転方法を';
Blockly.Msg.BLOCKS_MOTION_SET_ROTATION_STYLE_SUFFIX = 'にする';
Blockly.Msg.BLOCKS_MOTION_SELF_X = 'x座標';
Blockly.Msg.BLOCKS_MOTION_SELF_Y = 'y座標';
Blockly.Msg.BLOCKS_MOTION_SELF_ANGLE = '向き';

// blocks/events.js.coffee.erb
Blockly.Msg.BLOCKS_EVENTS_ON_START = '実行ボタンがクリックされたとき';
Blockly.Msg.BLOCKS_EVENTS_ON_KEY_PUSH_OR_DOWN_PREFIX = 'キーボードの';
Blockly.Msg.BLOCKS_EVENTS_ON_KEY_PUSH_OR_DOWN_MIDDLE = 'が';
Blockly.Msg.BLOCKS_EVENTS_ON_KEY_PUSH_OR_DOWN_SUFFIX = 'とき';
Blockly.Msg.BLOCKS_EVENTS_ON_CLICK = 'キャラクターがクリックされたとき';
Blockly.Msg.BLOCKS_EVENTS_ON_HIT_PREFIX = '';
Blockly.Msg.BLOCKS_EVENTS_ON_HIT_SUFFIX = 'にぶつかったとき';

// blocks/sensing.js.coffee.erb
Blockly.Msg.BLOCKS_SENSING_K_UP = '↑';
Blockly.Msg.BLOCKS_SENSING_K_DOWN = '↓';
Blockly.Msg.BLOCKS_SENSING_K_LEFT = '←';
Blockly.Msg.BLOCKS_SENSING_K_RIGHT = '→';
Blockly.Msg.BLOCKS_SENSING_K_SPACE = 'スペース';
Blockly.Msg.BLOCKS_SENSING_PUSH = '押された';
Blockly.Msg.BLOCKS_SENSING_HOLD_DOWN = '押され続けている';
Blockly.Msg.BLOCKS_SENSING_DOWN = Blockly.Msg.BLOCKS_SENSING_PUSH;
Blockly.Msg.BLOCKS_SENSING_M_LBUTTON = '左ボタン';
Blockly.Msg.BLOCKS_SENSING_M_MBUTTON = '中ボタン';
Blockly.Msg.BLOCKS_SENSING_M_RBUTTON = '右ボタン';
Blockly.Msg.BLOCKS_SENSING_UP = '押された';
Blockly.Msg.BLOCKS_SENSING_REACH_WALL = '端に触れた';
Blockly.Msg.BLOCKS_SENSING_INPUT_KEY_PUSH_OR_DOWN_PREFIX = 'キーボードの';
Blockly.Msg.BLOCKS_SENSING_INPUT_KEY_PUSH_OR_DOWN_MIDDLE = 'が';
Blockly.Msg.BLOCKS_SENSING_INPUT_KEY_PUSH_OR_DOWN_SUFFIX = '';
Blockly.Msg.BLOCKS_SENSING_INPUT_MOUSE_PUSH_OR_DOWN_PREFIX = 'マウスの';
Blockly.Msg.BLOCKS_SENSING_INPUT_MOUSE_PUSH_OR_DOWN_MIDDLE = 'が';
Blockly.Msg.BLOCKS_SENSING_INPUT_MOUSE_PUSH_OR_DOWN_SUFFIX = '';
Blockly.Msg.BLOCKS_SENSING_INPUT_MOUSE_POS_X = 'マウスのx座標';
Blockly.Msg.BLOCKS_SENSING_INPUT_MOUSE_POS_Y = 'マウスのy座標';
Blockly.Msg.BLOCKS_SENSING_HIT_PREFIX = '';
Blockly.Msg.BLOCKS_SENSING_HIT_SUFFIX = 'に触れた';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_X = 'x座標';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_Y = 'y座標';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_ANGLE = '向き';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_COSTUME_INDEX = 'コスチューム番号';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_COSTUME = 'コスチューム名';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_SCALE = '大きさ';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_VOLUME = 'ボリューム';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_MIDDLE = 'の';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_YEAR = '年';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_MONTH = '月';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_DAY = '日';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_WDAY = '曜日';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_HOUR = '時';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_MIN = '分';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_SEC = '秒';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW = '現在の';

// blocks/control.js.coffee.erb
Blockly.Msg.BLOCKS_CONTROL_SLEEP = '%1秒待つ';
Blockly.Msg.BLOCKS_CONTROL_LOOP = 'ずっと';
Blockly.Msg.BLOCKS_CONTROL_LOOP_END = 'を繰り返す';
Blockly.Msg.BLOCKS_CONTROL_BREAK = '繰り返しから脱出する';
Blockly.Msg.BLOCKS_CONTROL_NEXT = '次の繰り返しにジャンプする';
Blockly.Msg.BLOCKS_CONTROL_REDO = '現在の繰り返しをやり直す';
Blockly.Msg.BLOCKS_CONTROL_IF = 'もし';
Blockly.Msg.BLOCKS_CONTROL_THEN = 'ならば';
Blockly.Msg.BLOCKS_CONTROL_ELSE = 'でなければ';
Blockly.Msg.BLOCKS_CONTROL_TIMES = '%1回繰り返す';
Blockly.Msg.BLOCKS_CONTROL_AWAIT_UNTIL = '%1まで待つ';
Blockly.Msg.BLOCKS_CONTROL_UNTIL = '%1まで';
Blockly.Msg.BLOCKS_CONTROL_AWAIT = 'ほんの少し待つ';

// blocks/ruby.js.coffee.erb
Blockly.Msg.BLOCKS_RUBY_STATEMENT = '文';
Blockly.Msg.BLOCKS_RUBY_EXPRESSION = '式';
Blockly.Msg.BLOCKS_RUBY_COMMENT = 'コメント';

// blocks/field_character.js.coffee.erb
Blockly.Msg.BLOCKS_FIELD_CHARACTER_NO_CHARACTER = 'キャラクターなし';

// blocks/sound.js.coffee.erb
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_DO = 'ピアノのド';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_RE = 'ピアノのレ';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_MI = 'ピアノのミ';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_FA = 'ピアノのファ';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_SO = 'ピアノのソ';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_RA = 'ピアノのラ';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_SI = 'ピアノのシ';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_DO_2 = 'ピアノの高いド';
Blockly.Msg.BLOCKS_SOUND_PLAY = '%1の音を鳴らす';

// blocks/looks.js.coffee.erb
Blockly.Msg.BLOCKS_LOOKS_SAY = '%1と言う';
Blockly.Msg.BLOCKS_LOOKS_THINK = '%1と考える';
Blockly.Msg.BLOCKS_LOOKS_SAY_WITH_SECOND = '%1と%2秒と言う';
Blockly.Msg.BLOCKS_LOOKS_THINK_WITH_SECOND = '%1と%2秒と考える';
Blockly.Msg.BLOCKS_LOOKS_SHOW = '表示する';
Blockly.Msg.BLOCKS_LOOKS_HIDE = '隠す';
Blockly.Msg.BLOCKS_LOOKS_VANISH = '消滅する';

// blocks/hardware.js.coffee.erb
Blockly.Msg.BLOCKS_HARDWARE_LED_ON = 'オン';
Blockly.Msg.BLOCKS_HARDWARE_LED_OFF = 'オフ';
Blockly.Msg.BLOCKS_HARDWARE_ANODE = 'アノード';
Blockly.Msg.BLOCKS_HARDWARE_CATHODE = 'カソード';
Blockly.Msg.BLOCKS_HARDWARE_LEFT = ' 左';
Blockly.Msg.BLOCKS_HARDWARE_RIGHT = '右';
Blockly.Msg.BLOCKS_HARDWARE_INIT_HARDWARE = 'ハードウェアを準備する';
Blockly.Msg.BLOCKS_HARDWARE_RGB_LED_ON_1 = 'RGB LED';
Blockly.Msg.BLOCKS_HARDWARE_RGB_LED_ON_2 = 'コモン';
Blockly.Msg.BLOCKS_HARDWARE_RGB_LED_ON_3 = 'を';
Blockly.Msg.BLOCKS_HARDWARE_RGB_LED_ON_4 = 'にする';
Blockly.Msg.BLOCKS_HARDWARE_RGB_LED_OFF_1 = 'RGB LED';
Blockly.Msg.BLOCKS_HARDWARE_RGB_LED_OFF_2 = 'コモン';
Blockly.Msg.BLOCKS_HARDWARE_RGB_LED_OFF_3 = 'をオフにする';
Blockly.Msg.BLOCKS_HARDWARE_SEVEN_SEGMENT_DISPLAY_SHOW_1 = '7セグディスプレイに';
Blockly.Msg.BLOCKS_HARDWARE_SEVEN_SEGMENT_DISPLAY_SHOW_2 = 'を表示する';
Blockly.Msg.BLOCKS_HARDWARE_SEVEN_SEGMENT_DISPLAY_OFF = '7セグディスプレイをオフにする';
Blockly.Msg.BLOCKS_HARDWARE_LCD_PUTS = 'LCDに%1を表示する';
Blockly.Msg.BLOCKS_HARDWARE_LCD_CLEAR = 'LCDをクリアする';
Blockly.Msg.BLOCKS_HARDWARE_SERVO_SET_POSITION_1 = 'サーボ';
Blockly.Msg.BLOCKS_HARDWARE_SERVO_SET_POSITION_2 = 'を';
Blockly.Msg.BLOCKS_HARDWARE_SERVO_SET_POSITION_3 = '%1度(5～180)にする';

// blocks/operators.js.coffee.erb
Blockly.Msg.BLOCKS_OPERATORS_ADD = '%1＋%2';
Blockly.Msg.BLOCKS_OPERATORS_MINUS = '%1ー%2';
Blockly.Msg.BLOCKS_OPERATORS_MULTIPLY = '%1×%2';
Blockly.Msg.BLOCKS_OPERATORS_DIVIDE = '%1÷%2';
Blockly.Msg.BLOCKS_OPERATORS_COMPARE_LT = '%1＜%2';
Blockly.Msg.BLOCKS_OPERATORS_COMPARE_LTE = '%1≦%2';
Blockly.Msg.BLOCKS_OPERATORS_COMPARE_EQ = '%1＝%2';
Blockly.Msg.BLOCKS_OPERATORS_COMPARE_GTE = '%1≧%2';
Blockly.Msg.BLOCKS_OPERATORS_COMPARE_GT = '%1＞%2';
Blockly.Msg.BLOCKS_OPERATORS_RAND = '%1から%2までの乱数';
Blockly.Msg.BLOCKS_OPERATORS_AND = '%1かつ%2';
Blockly.Msg.BLOCKS_OPERATORS_OR = '%1または%2';
Blockly.Msg.BLOCKS_OPERATORS_NOT = '%1ではない';
Blockly.Msg.BLOCKS_OPERATORS_TRUE = '真';
Blockly.Msg.BLOCKS_OPERATORS_FALSE = '偽';
