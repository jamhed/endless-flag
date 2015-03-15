%% -*- mode: nitrogen -*-
%% vim: ts=4 sw=4 et
-module (element_dialog).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").
-export([
    reflect/0,
    render_element/1
]).

-spec reflect() -> [atom()].
reflect() -> record_info(fields, dialog).

-spec render_element(#dialog{}) -> body().
render_element(E = #dialog{}) ->
Panel = #panel{class="modal fade", id=E#dialog.id, body=[
    #panel{class="modal-dialog", body=[
        #panel{class="modal-content", body=[
            #panel{class="modal-header", body=[
                "<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>",
                #h4{class="modal-title",text=E#dialog.title}
            ]},
            wf_tags:emit_tag("div", E#dialog.body, [{class,"modal-body"}]),
            wf_tags:emit_tag("div", E#dialog.buttons, [{class,"modal-footer"}])
        ]}
    ]}
]},
wf:defer(Panel#panel.id, #dialog_show {}),
Panel.
