DIR.bx = '~/Desktop/PROP_BxData/';
DIR.out = [DIR.bx filesep 'output'];
DIR.compiled = [DIR.bx filesep 'compiled'];

filenames.TR = [DIR.compiled filesep 'usableTRcount'];
subList = [1:9 13];
nRuns = 2;
nSubs = length(subList);

studyCode = 'PROP';
taskCode = 'PROP';
usableTRcount = nan(max(subList),nRuns);

for s = subList
    
    if s<10
        placeholder = '00';
    elseif s<100
        placeholder = '0';
    else
        placeholder = '';
    end
    subjectCode = [studyCode placeholder num2str(s)];
    
    for r=1:nRuns
        
        filenames.out =  [DIR.out filesep 'sub-' subjectCode(end-2:end) '_ses-1_task-' taskCode '_run-' num2str(r) '_beh.mat'];
    
        if ~exist(filenames.out,'file')
            warning('No output file found for subject %d, run %d.\n',s,r);% import input file to determine eventIndices DO THIS
        else
            
            % import output file to determine actual onsets/durations DO THIS
            load(filenames.out)
            
            endTime = run_info.onsets(end)+run_info.durations(end);
            TRs = ceil(endTime/2);
            
            usableTRcount(s,r) = TRs;
            dlmwrite([filenames.TR '.txt'],usableTRcount,'delimiter','\t');
            save(filenames.TR,'usableTRcount');
        end
    end
    
end