%% Include the automatically generated plugins directory
-include("plugins.hrl").

%% Include any application-specific custom elements, actions, or validators below
-record(dialog, {?ELEMENT_BASE(element_dialog), body=[],buttons=[]}).
-record(dialog_close, {?ACTION_BASE(action_dialog)}).
-record(dialog_show, {?ACTION_BASE(action_dialog)}).
-record(fg, {?ELEMENT_BASE(element_fg), label="", placeholder="", value=""}).
