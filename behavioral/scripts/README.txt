Two tricky things:

(1) Sometimes people responded after the response screen. Those missing responses are recovered and put into run_info using ratings/responseCheckAndFix.m, which creates new output files. Then, extractRatings can use those updated output files to compile individual rating files and rating means. Also, makeVecs scripts can use those updated individual rating files for pmod creation. 

(2) Sometimes the scanner ended after the task ended. makeVecs/countUsableTRs.m counts how many usable TRs there are for subjects x runs.