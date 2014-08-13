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
