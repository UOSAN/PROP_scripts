DIR.bx = '~/Desktop/PROP_BxData/';
DIR.out = [DIR.bx filesep 'output_recoveredResp'];
DIR.rating = [DIR.bx filesep 'ratings'];
DIR.in = [DIR.bx filesep 'input'];
DIR.vec = [DIR.bx filesep 'vecs'];
DIR.thisFunk = '~/Desktop/PROP_scripts/behavioral/scripts/makeVecs/';
DIR.compiled = [DIR.bx filesep 'compiled'];

subList = [1:9 13];
nRuns = 2;
studyCode = 'PROP';
taskCode = 'PROP';
masterRatingMat = nan(max(subList),6);

for s = subList
    currentSubCBT = [];        
    currentSubPST = [];
            
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
        filenames.rating =  [DIR.rating filesep subjectCode '_run' num2str(r) '_ratings'];
        
        if ~exist(filenames.out,'file')
            warning('No output file found for subject %d, run %d.\n',s,r);% import input file to determine eventIndices DO THIS
        else
            
            % import output file to determine actual onsets/duration
            load(filenames.out)
             
            % Get event indices
            cbtIdx = cell2mat(cellfun(@(x) strcmp(x(1:3),'cbt'),run_info.tag,'UniformOutput',false));
            pstIdx = cell2mat(cellfun(@(x) strcmp(x(1:3),'pst'),run_info.tag,'UniformOutput',false));
            relIdx = cell2mat(cellfun(@(x) strcmp(x,'relevance'),run_info.tag,'UniformOutput',false));
            likeIdx = cell2mat(cellfun(@(x) strcmp(x,'liking'),run_info.tag,'UniformOutput',false));
            helpIdx = cell2mat(cellfun(@(x) strcmp(x,'helpfulness'),run_info.tag,'UniformOutput',false));
            ratingIdx = relIdx | likeIdx | helpIdx;
            
            sixAfterCBT = [0; 0; 0; 0; 0; 0; cbtIdx(1:end-6)];
            sixAfterPST = [0; 0; 0; 0; 0; 0; pstIdx(1:end-6)];
           
            cbtRelIdx = sixAfterCBT & relIdx;
            cbtLikeIdx = sixAfterCBT & likeIdx;
            cbtHelpIdx = sixAfterCBT & helpIdx;
            
            pstRelIdx = sixAfterPST & relIdx;
            pstLikeIdx = sixAfterPST & likeIdx;
            pstHelpIdx = sixAfterPST & helpIdx;
            
            % Extract responses
            responses = run_info.responses(ratingIdx);
            for resp = find(ratingIdx)'
                if isempty(run_info.responses{resp})
                    run_info.responses{resp} = NaN;
                    warning('missing response for run %d, event %d', r, resp)
                else
                   run_info.responses{resp} = str2num(run_info.responses{resp});
                end
            end
            
            cbtRatings = cell2mat([run_info.responses(cbtRelIdx)' run_info.responses(cbtHelpIdx)' run_info.responses(cbtLikeIdx)']);
            pstRatings = cell2mat([run_info.responses(pstRelIdx)' run_info.responses(pstHelpIdx)' run_info.responses(pstLikeIdx)']);
            cbtRatings = cbtRatings-4;
            pstRatings = pstRatings-4;
            
            nRatings(1) = size(cbtRatings,1);
            nRatings(2) = size(pstRatings,1);
            ratings = [[ones(nRatings(1),1); 2*ones(nRatings(2),1)] [cbtRatings; pstRatings]];
            
            save(filenames.rating,'cbtRatings','pstRatings')
            fid = fopen([filenames.rating '.txt'],'w');
            fprintf(fid,'%s\t%s\t%s\t%s\n','therapy','relevance','helpfulness','liking');
            for l=1:size(ratings,1)
                fprintf(fid,'%d\t%d\t%d\t%d\n', ratings(l,1),ratings(l,2),ratings(l,3),ratings(l,4));
            end
            fclose(fid);
            
            currentSubCBT = [currentSubCBT; cbtRatings];
            currentSubPST = [currentSubPST; pstRatings];
        
        end
    end
    
    cbtMeans = nanmean(currentSubCBT);
    pstMeans = nanmean(currentSubPST);
    overallMeans = nanmean([currentSubCBT;currentSubPST]);
    
    ratingMeans(s,1:3) = cbtMeans;
    ratingMeans(s,4:6) = pstMeans;
    ratingMeans(s,7:9) = overallMeans;
            
end

dlmwrite([DIR.compiled filesep 'ratingMeans.txt'],ratingMeans,'delimiter','\t')
save([DIR.compiled filesep 'ratingMeans.mat'],'ratingMeans')
