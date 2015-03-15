%% -*- mode: nitrogen -*-
%% vim: ts=4 sw=4 et
-module (action_dialog).
-include_lib ("nitrogen_core/include/wf.hrl").
-include("records.hrl").
-export([
    render_action/1
]).

-spec render_action(#dialog{}) -> actions().
render_action(#dialog_close{target = Target}) -> wf:f("console.log('close: ~s');jQuery(obj('~s')).remove();", [Target, Target]);
render_action(#dialog_show{target = Target}) -> wf:f("console.log('show:' + '~s' + ' : ' + obj('~s'));jQuery(obj('~s')).modal();", [Target, Target, Target]).

