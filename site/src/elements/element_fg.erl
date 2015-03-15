%% -*- mode: nitrogen -*-
%% vim: ts=4 sw=4 et
-module (element_fg).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").
-export([
    reflect/0,
    render_element/1
]).

-spec reflect() -> [atom()].
reflect() -> record_info(fields, fg).

-spec render_element(#fg{}) -> body().
render_element(E = #fg{}) ->
    LabelId = wf:temp_id(),
    #panel{class="form-group",body=[
        io_lib:format("<label for=\"~s\">~s</label>", [LabelId, E#fg.label]),
        #textbox{html_id=LabelId,placeholder=E#fg.placeholder,text=E#fg.value,id=E#fg.id,class="form-control"}
        ]}.
