function [actionmaster]=smoothing(actions)
actionmaster=actions;
for p=1:20000,
    %if psoactionmaster(p)>8000,
     actionmaster(p)=min(actions(1:p));
end