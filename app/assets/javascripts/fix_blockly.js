/**
 * this program copied from Blockly and modified
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

Blockly.Names.prototype.safeName_ = function(name) {
  if (!name) {
    name = 'unnamed';
  } else {
    // Unfortunately names in non-latin characters will look like
    // _E9_9F_B3_E4_B9_90 which is pretty meaningless.
    // HACK: Rubyでは日本語の変数名を許可しているためencodeURIを行わない。
    // また、使えない記号を置換する。
    name = name.replace(/[ !"#$%&'()=\-~^\\|`@{\[+;*:}\]<>,.?\/]/g, '_')
    // Most languages don't allow names with leading numbers.
    if ('0123456789'.indexOf(name[0]) != -1) {
      name = '_' + name;
    }
  }
  return name;
};

var originalBlocksMathNumberInit = Blockly.Blocks['math_number'].init;
Blockly.Blocks['math_number'].init = function() {
  originalBlocksMathNumberInit.call(this);
  this.setColour(100);
};

var originalBlocksTextInit = Blockly.Blocks['text'].init;
Blockly.Blocks['text'].init = function() {
  originalBlocksTextInit.call(this);
  this.setColour(100);
};

// HACK: fix could not play sound on IE11
Blockly.loadAudio_ = function(filenames, name) {
  if (!window['Audio'] || !filenames.length) {
    // No browser support for Audio.
    return;
  }
  var sound;
  var audioTest = new window['Audio']();
  for (var i = 0; i < filenames.length; i++) {
    var filename = filenames[i];
    var ext = filename.match(/\.(\w+)$/);
    if (ext && audioTest.canPlayType('audio/' + ext[1])) {
      // Found an audio format we can play.
      sound = new window['Audio'](Blockly.pathToBlockly + filename);
      break;
    }
  }
  // To force the browser to load the sound, play it, but at nearly zero volume.
  if (sound && sound.play) {
    sound.volume = 0.01;
    sound.play();
    sound.pause(); // added
    Blockly.SOUNDS_[name] = sound;
  }
};

// blockly/core/block.js
Blockly.Block.prototype.interpolateMsg = function(msg, var_args) {
  // Validate the msg at the start and the dummy alignment at the end,
  // and remove the latter.
  goog.asserts.assertString(msg);
  var dummyAlign = arguments[arguments.length - 1];
  goog.asserts.assert(
      dummyAlign === Blockly.ALIGN_LEFT ||
      dummyAlign === Blockly.ALIGN_CENTRE ||
      dummyAlign === Blockly.ALIGN_RIGHT,
      'Illegal final argument "%d" is not an alignment.', dummyAlign);
  arguments.length = arguments.length - 1;

  var tokens = msg.split(/(%\d)/);
  for (var i = 0; i < tokens.length; i += 2) {
    var text = goog.string.trim(tokens[i]);
    var symbol = tokens[i + 1];
    if (symbol) {
      // Value input.
      var digit = parseInt(symbol.charAt(1), 10);
      var tuple = arguments[digit];
      goog.asserts.assertArray(tuple,
          'Message symbol "%s" is out of range.', symbol);
      if (goog.typeOf(tuple[1]) == 'array' && tuple[1][0] == 'Dropdown') {
        this.appendDummyInput()
            .appendField(text)
            .setAlign(tuple[2])
            .appendField(new Blockly.FieldDropdown(tuple[1][1]), tuple[0]);
      }
      else if (goog.typeOf(tuple[1]) == 'array' && tuple[1][0] == 'Colour') {
        this.appendDummyInput()
            .appendField(text)
            .setAlign(tuple[2])
            .appendField(new Blockly.FieldColour(tuple[1][1]), tuple[0]);
      }
      else {
        this.appendValueInput(tuple[0])
            .setCheck(tuple[1])
            .setAlign(tuple[2])
            .appendField(text);
      }
      arguments[digit] = null;  // Inputs may not be reused.
    } else if (text) {
      this.appendDummyInput()
          .setAlign(dummyAlign)
          .appendField(text);
    }
  }
  // Verify that all inputs were used.
  for (var i = 1; i < arguments.length - 1; i++) {
    goog.asserts.assert(arguments[i] === null,
        'Input "%%s" not used in message: "%s"', i, msg);
  }
  // Make the inputs inline unless there is only one input and
  // no text follows it.
  this.setInputsInline(!msg.match(/%1\s*$/))
};
