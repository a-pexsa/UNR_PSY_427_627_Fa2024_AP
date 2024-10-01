%Time function

%% Get time on current clock, since computer startup
t0 = GetSecs; 

%% Wait a particular duration 
num_repeats = 10;
wait_duration = .5;
time_list = zeros(num_repeats, 1);
for i=1:num_repeats
    t1 = GetSecs;
    WaitSecs(wait_duration);
    t2 = GetSecs;
    t=(t2-t1);
    time_list(i,:)=t;
end
std(time_list)
%% Wait until a particular time
t3 = GetSecs;
WaitSecs('untiltime', t3+2)
t4 = GetSecs;
disp(t4-t3);

%%
Screen('Preference', 'SkipSyncTests', 1);         
[w,~]=Screen('OpenWindow', 0);
flip_time1 = Screen('Flip', w);
WaitSecs(.002);
flip_time2 = Screen('Flip',w);
sca;
rf = flip_time2-flip_time1;