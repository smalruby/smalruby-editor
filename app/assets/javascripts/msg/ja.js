goog.provide('Blockly.Msg.ja.smalruby');

goog.require('Blockly.Msg');


/**
 * Due to the frequency of long strings, the 80-column wrap rule need not apply
 * to message files.
 */

// fixed original messages
Blockly.Msg.DUPLICATE_BLOCK = "コピー";

// common
Blockly.Msg.COMMON_TURN_ON = 'オンにする';
Blockly.Msg.COMMON_TURN_OFF = 'オフにする';
Blockly.Msg.COMMON_FORWARD = '進める';
Blockly.Msg.COMMON_BACKWARD = 'バックさせる';
Blockly.Msg.COMMON_TURN_LEFT = '左に曲げる';
Blockly.Msg.COMMON_TURN_RIGHT = '右に曲げる';
Blockly.Msg.COMMON_STOP = '止める';
Blockly.Msg.COMMON_ERROR = 'エラー';
Blockly.Msg.COMMON_PROCESSING = '処理中...';


// colour name
Blockly.Msg.COLOUR_RED = '赤色';
Blockly.Msg.COLOUR_GREEN = '緑色';
Blockly.Msg.COLOUR_BLUE = '青色';
Blockly.Msg.COLOUR_WHITE = '白色';


// smalruby.js.coffee
Blockly.Msg.SMALRUBY_WILL_DISAPPER_YOUR_PROGRAM = '作成中のプログラムが消えてしまうよ！';


// views/main_menu_view.js.coffee
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_COMMON_LINES = '行';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_COMMON_LETTERS = '文字';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_COMMON_COMMA = '、';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_COMMON_CONFIRM_OVERWRITE = '前に{$filename}という名前でセーブしているけど本当にセーブしますか？\nセーブすると前に作成したプログラムは消えてしまうよ！';

Blockly.Msg.VIEWS_MAIN_MENU_VIEW_BLOCK_MODE_BLOCKUI_TITLE = 'プログラムの変換中';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_BLOCK_MODE_BLOCKUI_MESSAGE = 'プログラムをブロックに変換しています。';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_BLOCK_MODE_ERROR = 'ブロックへの変換に失敗しました';

Blockly.Msg.VIEWS_MAIN_MENU_VIEW_RUN_BLOCKUI_TITLE = 'プログラムの実行中';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_RUN_BLOCKUI_MESSAGE = 'プログラムの画面に切り替えてください。';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_RUN_BLOCKUI_NOTICE = 'プログラムをセーブ・チェックしてから実行するよ♪<br>Escキーを押すとプログラムが終わります。';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_RUN_ERROR_CANT_RUN = 'プログラムを実行できませんでした';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_RUN_ERROR_CANCEL_TO_RUN = 'プログラムの実行をキャンセルしました';

Blockly.Msg.VIEWS_MAIN_MENU_VIEW_DOWNLOAD_BLOCKUI_TITLE = 'プログラムのダウンロード中';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_DOWNLOAD_BLOCKUI_MESSAGE = 'プログラムをダウンロードしています。';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_DOWNLOAD_SUCCEEDED = 'ダウンロードしました。<br>ダウンロードしたプログラムは、Windowsだと「ruby {$filename}」、Macだと「rsdl {$filename}」で実行できます。';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_DOWNLOAD_ERROR = 'ダウンロードできませんでした';

Blockly.Msg.VIEWS_MAIN_MENU_VIEW_LOAD_CONFIRM = 'まだセーブしていないのでロードするとプログラムが消えてしまうよ！\nそれでもロードしますか？';

Blockly.Msg.VIEWS_MAIN_MENU_VIEW_SAVE_ERROR_NO_NAME = 'セーブする前にプログラムに名前をつけてね！';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_SAVE_BLOCKUI_TITLE = 'プログラムのセーブ中';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_SAVE_BLOCKUI_MESSAGE = 'プログラムをセーブしています。';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_SAVE_BLOCKUI_NOTICE = 'プログラムの名前は「{$filename}」です。<br>プログラムはホームディレクトリにセーブします。<br>';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_SAVE_ERROR_MESSAGE = 'セーブできませんでした';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_SAVE_CANCELED = 'セーブをキャンセルしました';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_SAVE_SUCCEEDED = 'セーブしました';

Blockly.Msg.VIEWS_MAIN_MENU_VIEW_CHECK_BLOCKUI_TITLE = 'プログラムのチェック中';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_CHECK_BLOCKUI_MESSAGE = 'プログラムの文法をチェックしています。';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_CHECK_BLOCKUI_NOTICE = 'このチェックは簡易的なものですので、<br>プログラムを動かすとエラーが見つかるかもしれません。';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_CHECK_SUCCEEDED = 'チェックしました';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_CHECK_SUCCEEDED_NOTICE = 'ただし、プログラムを動かすとエラーが見つかるかもしれません。';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_CHECK_ERROR = 'チェックできませんでした';

Blockly.Msg.VIEWS_MAIN_MENU_VIEW_SIGNOUT_SUCCEEDED = 'ログアウトしました';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_SIGNOUT_ERROR = 'ログアウトに失敗しました';

Blockly.Msg.VIEWS_MAIN_MENU_VIEW_LOAD_ERROR = '{$filename}{$error}';
Blockly.Msg.VIEWS_MAIN_MENU_VIEW_LOAD_SUCCEEDED = 'ロードしました';


// views/load_modal_view.js.coffee
Blockly.Msg.VIEWS_LOAD_MODAL_VIEW_ERROR = 'ロードに失敗しました';


// views/signin_modal_view.js.coffee
Blockly.Msg.VIEWS_SIGNIN_MODAL_VIEW_SIGNED_IN = 'ログインしました';
Blockly.Msg.VIEWS_SIGNIN_MODAL_VIEW_ERROR = 'ログインに失敗しました';


// blocks/motion.js.coffee.erb
Blockly.Msg.BLOCKS_MOTION_MOVE = '■%1歩動かす';
Blockly.Msg.BLOCKS_MOTION_MOVE2 = '■%1歩動かす2';
Blockly.Msg.BLOCKS_MOTION_TURN_RIGHT_DEGREES = '■時計回りに%1度回す';
Blockly.Msg.BLOCKS_MOTION_TURN_LEFT_DEGREES = '■反時計回りに%1度回す';
Blockly.Msg.BLOCKS_MOTION_POINT_IN_DIRECTION = '■%1 度に向ける';
Blockly.Msg.BLOCKS_MOTION_POINT_TOWARDS_MOUSE = '■マウスポインターへ向ける';
Blockly.Msg.BLOCKS_MOTION_POINT_TOWARDS_CHARACTER = '■%1 へ向ける';
Blockly.Msg.BLOCKS_MOTION_SET_X_Y = '■x座標を %1 、y座標を %2 にする';
Blockly.Msg.BLOCKS_MOTION_GO_TO_MOUSE = '■マウスポインターへ行く';
Blockly.Msg.BLOCKS_MOTION_GO_TO_CHARACTER = '■%1 へ行く';
Blockly.Msg.BLOCKS_MOTION_CHANGE_X_BY = '■x座標を %1 ずつ変える';
Blockly.Msg.BLOCKS_MOTION_SET_X = '■x座標を %1 にする';
Blockly.Msg.BLOCKS_MOTION_CHANGE_Y_BY = '■y座標を %1 ずつ変える';
Blockly.Msg.BLOCKS_MOTION_SET_Y = '■y座標を %1 にする';
Blockly.Msg.BLOCKS_MOTION_TURN_IF_REACH_WALL = '■もし端に着いたら、跳ね返る';
Blockly.Msg.BLOCKS_MOTION_TURN = '■跳ね返る';
Blockly.Msg.BLOCKS_MOTION_TURN_XY_X = '水平(x)';
Blockly.Msg.BLOCKS_MOTION_TURN_XY_Y = '垂直(y)';
Blockly.Msg.BLOCKS_MOTION_TURN_XY = '■%1 方向に跳ね返る';
Blockly.Msg.BLOCKS_MOTION_SET_ROTATION_STYLE_LEFT_RIGHT = '左右のみ';
Blockly.Msg.BLOCKS_MOTION_SET_ROTATION_STYLE_NONE = '回転しない';
Blockly.Msg.BLOCKS_MOTION_SET_ROTATION_STYLE_FREE = '自由に回転';
Blockly.Msg.BLOCKS_MOTION_SET_ROTATION_STYLE = '■回転方法を %1 にする';
Blockly.Msg.BLOCKS_MOTION_SELF_X = '■x座標';
Blockly.Msg.BLOCKS_MOTION_SELF_Y = '■y座標';
Blockly.Msg.BLOCKS_MOTION_SELF_ANGLE = '■向き';


// blocks/events.js.coffee.erb
Blockly.Msg.BLOCKS_EVENTS_ON_START = '♣実行ボタンがクリックされたとき';
Blockly.Msg.BLOCKS_EVENTS_ON_KEY_PUSH_OR_DOWN = '♣キーボードの %1 が %2 のとき';
Blockly.Msg.BLOCKS_EVENTS_ON_CLICK = '♣キャラクターがクリックされたとき';
Blockly.Msg.BLOCKS_EVENTS_ON_HIT = '♣%1 にぶつかったとき';


// blocks/sensing.js.coffee.erb
Blockly.Msg.BLOCKS_SENSING_K_UP = '↑';
Blockly.Msg.BLOCKS_SENSING_K_DOWN = '↓';
Blockly.Msg.BLOCKS_SENSING_K_LEFT = '←';
Blockly.Msg.BLOCKS_SENSING_K_RIGHT = '→';
Blockly.Msg.BLOCKS_SENSING_K_SPACE = 'スペース';
Blockly.Msg.BLOCKS_SENSING_PRESSED = '押された';
Blockly.Msg.BLOCKS_SENSING_PUSH = Blockly.Msg.BLOCKS_SENSING_PRESSED;
Blockly.Msg.BLOCKS_SENSING_UP = Blockly.Msg.BLOCKS_SENSING_PRESSED;
Blockly.Msg.BLOCKS_SENSING_HOLD_PRESSED = '押され続けている';
Blockly.Msg.BLOCKS_SENSING_HOLD_DOWN = Blockly.Msg.BLOCKS_SENSING_HOLD_PRESSED;
Blockly.Msg.BLOCKS_SENSING_M_LBUTTON = '左ボタン';
Blockly.Msg.BLOCKS_SENSING_M_MBUTTON = '中ボタン';
Blockly.Msg.BLOCKS_SENSING_M_RBUTTON = '右ボタン';
Blockly.Msg.BLOCKS_SENSING_RELEASED = '離された';
Blockly.Msg.BLOCKS_SENSING_UP = Blockly.Msg.BLOCKS_SENSING_RELEASED;
Blockly.Msg.BLOCKS_SENSING_REACH_WALL = '◎端に触れた';
Blockly.Msg.BLOCKS_SENSING_INPUT_KEY_PUSH_OR_DOWN_PREFIX = '◎キーボードの';
Blockly.Msg.BLOCKS_SENSING_INPUT_KEY_PUSH_OR_DOWN_MIDDLE = 'が';
Blockly.Msg.BLOCKS_SENSING_INPUT_KEY_PUSH_OR_DOWN_SUFFIX = '';
Blockly.Msg.BLOCKS_SENSING_INPUT_MOUSE_PUSH_OR_DOWN_PREFIX = '◎マウスの';
Blockly.Msg.BLOCKS_SENSING_INPUT_MOUSE_PUSH_OR_DOWN_MIDDLE = 'が';
Blockly.Msg.BLOCKS_SENSING_INPUT_MOUSE_PUSH_OR_DOWN_SUFFIX = '';
Blockly.Msg.BLOCKS_SENSING_INPUT_MOUSE_POS_X = '◎マウスのx座標';
Blockly.Msg.BLOCKS_SENSING_INPUT_MOUSE_POS_Y = '◎マウスのy座標';
Blockly.Msg.BLOCKS_SENSING_HIT_PREFIX = '◎';
Blockly.Msg.BLOCKS_SENSING_HIT_SUFFIX = 'に触れた';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_X = 'x座標';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_Y = 'y座標';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_ANGLE = '向き';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_COSTUME_INDEX = 'コスチューム番号';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_COSTUME = 'コスチューム名';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_SCALE = '大きさ';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY_VOLUME = 'ボリューム';
Blockly.Msg.BLOCKS_SENSING_CHARACTER_PROPERTY = '◎%1 の %2';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_YEAR = '年';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_MONTH = '月';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_DAY = '日';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_WDAY = '曜日';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_HOUR = '時';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_MIN = '分';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW_SEC = '秒';
Blockly.Msg.BLOCKS_SENSING_TIME_NOW = '◎現在の %1';
Blockly.Msg.BLOCKS_SENSING_DAYS_SINCE_2000 = '◎2000年からの日数';


// blocks/control.js.coffee.erb
Blockly.Msg.BLOCKS_CONTROL_SLEEP = '◆%1秒待つ';
Blockly.Msg.BLOCKS_CONTROL_LOOP = '◆ずっと';
Blockly.Msg.BLOCKS_CONTROL_LOOP_END = 'を繰り返す';
Blockly.Msg.BLOCKS_CONTROL_BREAK = '◆繰り返しから脱出する';
Blockly.Msg.BLOCKS_CONTROL_NEXT = '◆以降の処理を飛ばして、次の回の処理を開始する';
Blockly.Msg.BLOCKS_CONTROL_REDO = '◆以降の処理を飛ばして、もう一度同じ処理をやり直す';
Blockly.Msg.BLOCKS_CONTROL_IF = '◆もし';
Blockly.Msg.BLOCKS_CONTROL_THEN = 'ならば';
Blockly.Msg.BLOCKS_CONTROL_ELSE = 'でなければ';
Blockly.Msg.BLOCKS_CONTROL_TIMES = '◆%1回繰り返す';
Blockly.Msg.BLOCKS_CONTROL_AWAIT_UNTIL = '◆%1まで待つ';
Blockly.Msg.BLOCKS_CONTROL_UNTIL = '◆%1まで';
Blockly.Msg.BLOCKS_CONTROL_AWAIT = '◆ほんの少し待つ';


// blocks/ruby.js.coffee.erb
Blockly.Msg.BLOCKS_RUBY_STATEMENT = '♠文';
Blockly.Msg.BLOCKS_RUBY_EXPRESSION = '♠式';
Blockly.Msg.BLOCKS_RUBY_COMMENT = '♠コメント';
Blockly.Msg.BLOCKS_RUBY_P = '♠p %1';


// blocks/field_character.js.coffee.erb
Blockly.Msg.BLOCKS_FIELD_CHARACTER_NO_CHARACTER = 'キャラクターなし';
Blockly.Msg.BLOCKS_FIELD_CHARACTER_FIRST_COSTUME = '最初のコスチューム';


// blocks/sound.js.coffee.erb
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS = '♪%1';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_DO = 'ピアノのド';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_RE = 'ピアノのレ';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_MI = 'ピアノのミ';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_FA = 'ピアノのファ';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_SO = 'ピアノのソ';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_RA = 'ピアノのラ';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_SI = 'ピアノのシ';
Blockly.Msg.BLOCKS_SOUND_PRESET_SOUNDS_PIANO_DO_2 = 'ピアノの高いド';
Blockly.Msg.BLOCKS_SOUND_PLAY = '♪%1 の音を鳴らす';


// blocks/looks.js.coffee.erb
Blockly.Msg.BLOCKS_LOOKS_SAY = '★%1 と言う';
Blockly.Msg.BLOCKS_LOOKS_THINK = '★%1 と考える';
Blockly.Msg.BLOCKS_LOOKS_SAY_WITH_SECOND = '★%1 と %2 秒と言う';
Blockly.Msg.BLOCKS_LOOKS_THINK_WITH_SECOND = '★%1 と %2 秒と考える';
Blockly.Msg.BLOCKS_LOOKS_SHOW = '★表示する';
Blockly.Msg.BLOCKS_LOOKS_HIDE = '★隠す';
Blockly.Msg.BLOCKS_LOOKS_VANISH = '★消滅する';
Blockly.Msg.BLOCKS_LOOKS_NEXT_COSTUME = '★次のコスチュームにする';
Blockly.Msg.BLOCKS_LOOKS_SWITCH_COSTUME = '★コスチュームを %1 にする';


// blocks/hardware.js.coffee.erb
Blockly.Msg.BLOCKS_HARDWARE_LED_TURN_ON = '★LED %1 をオンにする';
Blockly.Msg.BLOCKS_HARDWARE_LED_TURN_OFF = '★LED %1 をオフにする';
Blockly.Msg.BLOCKS_HARDWARE_ANODE = 'アノード';
Blockly.Msg.BLOCKS_HARDWARE_CATHODE = 'カソード';
Blockly.Msg.BLOCKS_HARDWARE_LEFT = ' 左';
Blockly.Msg.BLOCKS_HARDWARE_RIGHT = '右';
Blockly.Msg.BLOCKS_HARDWARE_INIT_HARDWARE = '♠ハードウェアを準備する';
Blockly.Msg.BLOCKS_HARDWARE_NEO_PIXEL_SET_RGB = '★マイコン内蔵RGB LED %1 を赤 %2 緑 %3 青 %4 にする';
Blockly.Msg.BLOCKS_HARDWARE_RGB_LED_SET_COLOR = '★RGB LED %1 コモン %2 を %3 にする';
Blockly.Msg.BLOCKS_HARDWARE_RGB_LED_TURN_OFF = '★RGB LED %1 コモン %2 をオフにする';
Blockly.Msg.BLOCKS_HARDWARE_SEVEN_SEGMENT_DISPLAY_SHOW = '★7セグディスプレイに %1 を表示する';
Blockly.Msg.BLOCKS_HARDWARE_SEVEN_SEGMENT_DISPLAY_OFF = '★7セグディスプレイをオフにする';
Blockly.Msg.BLOCKS_HARDWARE_LCD_PUTS = '★LCDに %1 を表示する';
Blockly.Msg.BLOCKS_HARDWARE_LCD_CLEAR = '★LCDをクリアする';
Blockly.Msg.BLOCKS_HARDWARE_SERVO_SET_POSITION = '■サーボ %1 を %2 度(5～180)にする';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_FORWARD = '■2WD車 %1 を進める';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_BACKWARD = '■2WD車 %1 をバックさせる';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_TURN_LEFT = '■2WD車 %1 を左に曲げる';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_TURN_RIGHT = '■2WD車 %1 を右に曲げる';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_STOP = '■2WD車 %1 を止める';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_RUN = '■2WD車 %2 を %3 秒 %1';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_COMMANDS = '■%1';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_COMMANDS_FORWARD = '進める';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_COMMANDS_BACKWARD = 'バックさせる';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_COMMANDS_TURN_LEFT = '左に曲げる';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_COMMANDS_TURN_RIGHT = '右に曲げる';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_COMMANDS_STOP = '止める';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_SET_SPEED = '■2WD車 %1 の %2 の速度(%)を %3 にする';
Blockly.Msg.BLOCKS_HARDWARE_TWO_WHEEL_DRIVE_CAR_SPEED = '◎2WD車 %1 の %2 の速度(%)';
Blockly.Msg.BLOCKS_HARDWARE_MOTOR_DRIVER_FORWARD = '正転させる';
Blockly.Msg.BLOCKS_HARDWARE_MOTOR_DRIVER_BACKWARD = '逆転させる';
Blockly.Msg.BLOCKS_HARDWARE_MOTOR_DRIVER_STOP = '止める';
Blockly.Msg.BLOCKS_HARDWARE_MOTOR_DRIVER = '■(モータードライバ %1 で)モーターを %2';
Blockly.Msg.BLOCKS_HARDWARE_MOTOR_DRIVER_SET_SPEED = '■(モータードライバ %1 の)モーターの速度を %2 にする';
Blockly.Msg.BLOCKS_HARDWARE_MOTOR_DRIVER_SPEED = '◎(モータードライバ %1 の)モーターの速度(%)';
Blockly.Msg.BLOCKS_HARDWARE_BUTTON_PRESSED_OR_RELEASED = '◎ボタン %1 が %2 ？';
Blockly.Msg.BLOCKS_HARDWARE_SENSOR_VALUE = '◎センサー %1';
Blockly.Msg.BLOCKS_HARDWARE_SMALRUBOT_V3_LED_TURN_ON_OR_OFF = '★スモウルボットV3の %1 のLEDを %2';
Blockly.Msg.BLOCKS_HARDWARE_SMALRUBOT_V3_ACTION = '■スモウルボットV3を %1';
Blockly.Msg.BLOCKS_HARDWARE_SMALRUBOT_V3_ACTION_WITH_SEC = '■スモウルボットV3を %2 秒 %1';
Blockly.Msg.BLOCKS_HARDWARE_SMALRUBOT_V3_SENSOR_VALUE = '◎スモウルボットV3の %1 のセンサー';
Blockly.Msg.BLOCKS_HARDWARE_SMALRUBOT_V3_DC_MOTOR_POWER_RATIO = '◎スモウルボットV3の %1 DCモーターの速度(%)';
Blockly.Msg.BLOCKS_HARDWARE_SMALRUBOT_V3_DC_MOTOR_SET_POWER_RATIO = '■スモウルボットV3の %1 DCモーターの速度を %2 (%) にする';
Blockly.Msg.BLOCKS_HARDWARE_SMALRUBOT_S1_LED_TURN_ON_OR_OFF = '★スモウルボットS1の %1 のLEDを %2';
Blockly.Msg.BLOCKS_HARDWARE_SMALRUBOT_S1_ACTION = '■スモウルボットS1を %1';
Blockly.Msg.BLOCKS_HARDWARE_SMALRUBOT_S1_ACTION_WITH_SEC = '■スモウルボットS1を %2 秒 %1';
Blockly.Msg.BLOCKS_HARDWARE_SMALRUBOT_S1_SENSOR_VALUE = '◎スモウルボットS1の %1 のセンサー';
Blockly.Msg.BLOCKS_HARDWARE_SMALRUBOT_S1_DC_MOTOR_POWER_RATIO = '◎スモウルボットS1の %1 DCモーターの速度(%)';
Blockly.Msg.BLOCKS_HARDWARE_SMALRUBOT_S1_DC_MOTOR_SET_POWER_RATIO = '■スモウルボットS1の %1 DCモーターの速度を %2 (%) にする';


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
Blockly.Msg.BLOCKS_OPERATORS_INDEX_OF = '%1の%2番目';
Blockly.Msg.BLOCKS_OPERATORS_LENGTH = '%1の長さ';
Blockly.Msg.BLOCKS_OPERATORS_MODULO = '%1を%2で割った余り';
Blockly.Msg.BLOCKS_OPERATORS_ROUND = '%1を四捨五入';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD = '%1の%2';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_ABS = '絶対値';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_FLOOR = '切り上げ';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_CEIL = '切り下げ';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_SQRT = '平方根';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_SIN = 'sin';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_COS = 'cos';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_TAN = 'tan';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_ASIN = 'asin';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_ACOS = 'acos';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_ATAN = 'atan';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_LN = 'log';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_LOG = 'log10';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_E_SQUARE = 'e ^';
Blockly.Msg.BLOCKS_OPERATORS_MATH_METHOD_10_SQUARE = '10 ^';
Blockly.Msg.BLOCKS_OPERATORS_TRUE = '真';
Blockly.Msg.BLOCKS_OPERATORS_FALSE = '偽';


// blocks/pen.js.coffee.erb
Blockly.Msg.BLOCKS_PEN_DOWN_PEN = '●ペンを下ろす';
Blockly.Msg.BLOCKS_PEN_UP_PEN = '●ペンを上げる';
Blockly.Msg.BLOCKS_PEN_SET_PEN_COLOR = '●ペンの色を%1にする';


// override blockly's messages
Blockly.Msg.VARIABLES_SET_TITLE = '☼セット';
Blockly.Msg.VARIABLES_GET_TITLE = '☼';
