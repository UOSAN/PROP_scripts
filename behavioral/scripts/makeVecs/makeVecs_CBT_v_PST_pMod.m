DIR.bx = '~/Desktop/PROP_BxData/';
DIR.out = [DIR.bx filesep 'output_recoveredResp'];
DIR.in = [DIR.bx filesep 'input'];
DIR.vec = [DIR.bx filesep 'vecs'];
DIR.thisFunk = '~/Desktop/PROP_scripts/behavioral/scripts/makeVecs/';
DIR.rating = [DIR.bx filesep 'ratings'];
DIR.compiled = [DIR.bx filesep 'compiled'];

subList = [1:9 13];
nRuns = 2;
studyCode = 'PROP';
taskCode = 'PROP';
modelCode = 'CBT_v_PST_pMod';
% Saving SPM-ready names, onsets, and durations to .mat

DIR.vecModel = [DIR.vec filesep modelCode];
if ~exist(DIR.vecModel)
    mkdir(DIR.vecModel)
end
filenames.ratingMeans = 'ratingMeans.mat';

names = {'cbt' 'pst' 'instrux' 'rating'};
nConds = length(names);
load([DIR.compiled filesep filenames.ratingMeans])
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
        filenames.vec = [DIR.vecModel filesep subjectCode '_run' num2str(r) '_' modelCode];
        filenames.rating =  [DIR.rating filesep subjectCode '_run' num2str(r) '_ratings'];
        onsets = cell(1,nConds);
        durations = cell(1,nConds);
        pmod = struct;
        for cond = 1:2
            pmod(cond).name = {'relevance' 'liking' 'helpfulness'};
            nPmods = length(pmod(cond).name);
            pmod(cond).param = cell(1,nPmods);
            pmod(cond).poly = {1 1 1};
        end
        
        if ~exist(filenames.out,'file')
            warning('No output file found for subject %d, run %d.\n',s,r);% import input file to determine eventIndices DO THIS
        else
            
            % import output file to determine actual onsets/durations DO THIS
            load(filenames.out)
            
            % Get event indices
            cbtIdx = cell2mat(cellfun(@(x) strcmp(x(1:3),'cbt'),run_info.tag,'UniformOutput',false));
            pstIdx = cell2mat(cellfun(@(x) strcmp(x(1:3),'pst'),run_info.tag,'UniformOutput',false));
            relIdx = cell2mat(cellfun(@(x) strcmp(x,'relevance'),run_info.tag,'UniformOutput',false));
            likeIdx = cell2mat(cellfun(@(x) strcmp(x,'liking'),run_info.tag,'UniformOutput',false));
            helpIdx = cell2mat(cellfun(@(x) strcmp(x,'helpfulness'),run_info.tag,'UniformOutput',false));
            
            instruxIdx = cell2mat(cellfun(@(x) strcmp(x,'instrux'),run_info.tag,'UniformOutput',false));
            vignetteStartIdx = [0;0;instruxIdx(1:end-2)];
            vignetteEndIdx = [relIdx(3:end);0;0];
            ratingIdx = relIdx | likeIdx | helpIdx;
            cbtStartIdx = cbtIdx & vignetteStartIdx;
            pstStartIdx = pstIdx & vignetteStartIdx;
            cbtEndIdx = cbtIdx & vignetteEndIdx;
            pstEndIdx = pstIdx & vignetteEndIdx;
            
            onsets{1} = run_info.onsets(cbtStartIdx);
            onsets{2} = run_info.onsets(pstStartIdx);
            onsets{3} = run_info.onsets(instruxIdx);
            onsets{4} = run_info.onsets(ratingIdx);
            
            cbtOffsets = run_info.onsets(cbtEndIdx) + run_info.durations(cbtEndIdx);
            pstOffsets = run_info.onsets(pstEndIdx) + run_info.durations(pstEndIdx);
            
            durations{1} = cbtOffsets - onsets{1};
            durations{2} = pstOffsets - onsets{2};
            durations{3} = run_info.durations(instruxIdx);
            durations{4} = run_info.durations(ratingIdx);
            
            load(filenames.rating)
            subRatingMeans = ratingMeans(s,7:9);
            for p = 1:nPmods % for each rating type
                % Set up p-th pmod for CBT cond
                pmod1 = cbtRatings(:,p) - subRatingMeans(p); 
                pmod1(isnan(pmod1)) = 0; % Make NaNs = 0 (mean)
                pmod(1).param{p} = pmod1;
                
                pmod2 = pstRatings(:,p) - subRatingMeans(p); % set up p-th pmod for PST cond
                pmod2(isnan(pmod2)) = 0; % Make NaNs = 0 (mean)
                pmod(2).param{p} = pmod2;
            end
            
            % save vec file for this run
            save(filenames.vec,'names','onsets','durations','pmod')
        end
    end
    
end

cd(DIR.thisFunk)