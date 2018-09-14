DIR.bx = '~/Desktop/PROP_BxData/';
DIR.out = [DIR.bx filesep 'output'];
DIR.outRecovered = [DIR.bx filesep 'output_recoveredResp'];

subList = [1:9 13];
nRuns = 2;
studyCode = 'PROP';
taskCode = 'PROP';
masterMat = [];
filenames.respCheck = [DIR.bx filesep 'compiled' filesep 'responseComparison'];
nFoundResponses = [];

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
        filenames.outRecovered =  [DIR.outRecovered filesep 'sub-' subjectCode(end-2:end) '_ses-1_task-' taskCode '_run-' num2str(r) '_beh.mat'];
        
        if ~exist(filenames.out,'file')
            warning('No output file found for subject %d, run %d.\n',s,r);% import input file to determine eventIndices DO THIS
        else
            
            % import output file to determine actual onsets/duration
            load(filenames.out)
            
            relIdx = cell2mat(cellfun(@(x) strcmp(x,'relevance'),run_info.tag,'UniformOutput',false));
            likeIdx = cell2mat(cellfun(@(x) strcmp(x,'liking'),run_info.tag,'UniformOutput',false));
            helpIdx = cell2mat(cellfun(@(x) strcmp(x,'helpfulness'),run_info.tag,'UniformOutput',false));
            ratingIdx = relIdx | likeIdx | helpIdx;
            
            keypressTimeTemp = key_presses.time;
            for i=2:length(key_presses.time)
                if key_presses.time(i)-key_presses.time(i-1)<.5
                    keypressTimeTemp(i)=0;
                end
            end
            key_presses.time = keypressTimeTemp;
            
            % Compare number of keypresses logged to number of responses
            % logged within run_info.responses
            
            keypressesLogged = sum(key_presses.time>0);
            responsesWithinRunInfo = length(run_info.responses)-sum(cellfun('isempty',run_info.responses));           
            masterMat(end+1,:) = [s r keypressesLogged responsesWithinRunInfo keypressesLogged-responsesWithinRunInfo];
            
            % Create Time Log of Ratings, Keypresses, and post-rating Fixations
            % Rating = 1; Fixation = 0; Keypresses = 2
            
            keyLog = key_presses.time(key_presses.time>0)';
            rateLog = run_info.onsets(ratingIdx)';
            fixLog = run_info.onsets(logical([0;ratingIdx(1:end-1)]))'; % fixations that mark the end of rating
            
            fullLog = [[ones(length(rateLog),1) rateLog]; [2*ones(length(keyLog),1) keyLog]; [zeros(length(fixLog),1) fixLog]];
            fullLog = sortrows(fullLog,2);
            
            isRating = fullLog(:,1)==1;
            isFix = fullLog(:,1)==0;
            isKey = fullLog(:,1)==2;
            
            % Find ratings that are followed by fixation (no response):
            isFixNext = [isFix(2:end);0];
            isMissingRating = isRating & isFixNext;
            % This is just a sanity check that this matches the missing 
            % rating count. (It does)
            
            % Find keypresses that happen immediatey after rating period has ended:
            isFixBefore = [0;isFix(1:end-1)];
            isRating2Before = [0;0;isRating(1:end-2)];
            isKeyAfterFix = isKey & isFixBefore & isRating2Before;
            nFoundResponses(end+1) = sum(isKeyAfterFix);
            
            recoveredKeyTimes = fullLog(isKeyAfterFix,2);
            isRatingWithKeyAfterFix = logical([isKeyAfterFix(3:end);0;0]);
            recoveredRatingTimes = fullLog(isRatingWithKeyAfterFix,2);
            
            for k=1:length(recoveredKeyTimes)
                % Find key idx within key_press variable:
                recoveredKeyIdx = find(key_presses.time==recoveredKeyTimes(k));
                % Get recovered value:
                recoveredKeyVal = key_presses.key(recoveredKeyIdx);
                
                % Meanwhile, in the run_info variable, find rating idx:
                recoveredRatingIdx_runInfo = find(run_info.onsets==recoveredRatingTimes(k));
                % Put recovered value in run_info.responses:
                run_info.responses(recoveredRatingIdx_runInfo) = recoveredKeyVal;
            end
            save(filenames.outRecovered,'key_presses','run_info')
            
        end
    end
end
nMissingResponses = 30-masterMat(:,4);

fid = fopen([filenames.respCheck '.txt'],'w');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\n','sub','run','keys logged','run_info.responses','missing','found');
for l=1:size(masterMat,1)
    fprintf(fid,'%d\t%d\t%d\t%d\t%d\t%d\n', masterMat(l,1),masterMat(l,2),masterMat(l,3),masterMat(l,4),nMissingResponses(l),nFoundResponses(l));
end
fclose(fid);

fprintf('Recovered values: %d of %d missing keys across all subs, all runs.\n',sum(nFoundResponses),sum(nMissingResponses))