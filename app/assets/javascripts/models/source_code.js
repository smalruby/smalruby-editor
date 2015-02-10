/**
 * ソースコードを表現するモデル
 */
Smalruby.SourceCode = Backbone.Model.extend({
  defaults: {
    filename: null,
    data: null
  },

  initialize: function() {
    if (!this.get('filename')) {
      var filename = Smalruby.Views.MainMenuView.getFilename();
      if (filename.length == 0) {
        filename = Smalruby.SourceCode.defaultFilename();
      }
      this.set('filename', filename);
    }

    if (!this.get('data')) {
      if (this.get('filename').match(/\.xml$/)) {
        var data = Smalruby.dumpXml();
      }
      else {
        if (window.blockMode) {
          var data = Blockly.Ruby.workspaceToCode();
        }
        else {
          var data = window.textEditor.getSession().getDocument().getValue();
        }
      }
      this.set('data', data);
    }
  },

  getRbxmlFilename: function() {
    var filename = this.get('filename');
    if (filename.match(/\.rb\.xml$/)) {
      return filename;
    }
    else {
      if (filename.match(/\.rb$/)) {
        return filename + '.xml';
      }
      else if (filename.match(/\.xml$/)) {
        return filename.replace(/\.xml$/, '.rb.xml');
      }
      else {
        return filename + '.rb.xml';
      }
    }
  },

  run: function() {
    return this.post_('run');
  },

  check: function() {
    return this.post_('check');
  },

  save2: function() {
    return this.post_('');
  },

  write: function(force) {
    if (force == null) {
      force = false;
    }
    var action = 'write';
    if (force) {
      action += '?force=1';
    }
    return this.delete_(action);
  },

  toBlocks: function() {
    return this.post_('to_blocks', 'html');
  },

  post_:  function(action, dataType) {
    if (dataType == null) {
      dataType = 'json';
    }
    dfr = $.Deferred();
    $.ajax({
      url: '/source_codes/' + action,
      type: 'POST',
      data: {
        source_code: {
          filename: this.get('filename'),
          data: this.get('data')
        }
      },
      dataType: dataType,
      success: function(data, textStatus, jqXHR) {
        return dfr.resolve(data);
      },
      error: dfr.reject
    });
    return dfr.promise();
  },

  delete_: function(action) {
    dfr = $.Deferred();
    $.ajax({
      url: '/source_codes/' + action,
      type: 'DELETE',
      dataType: 'json',
      success: function(data, textStatus, jqXHR) {
        return dfr.resolve(data);
      },
      error: dfr.reject
    });
    return dfr.promise();
  }
}, {
  defaultFilename: function(now) {
    if (now == null) {
      now = new Date();
    }
    return strftime('program_%y%m%d_%H%M%S.rb', now);
  }
});
