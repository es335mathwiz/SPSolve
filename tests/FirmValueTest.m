classdef FirmValueTest < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        OriginalPath
        parnam
        modnam
        dirnam
    end
    
    methods (TestMethodSetup)
        function addTestDirToPath(testCase)
            if(SPWindowsQ)
                testCase.dirnam=strcat(SPSolveTestDir,'firmValue\');
            else
                testCase.dirnam=strcat(SPSolveTestDir,'firmValue/') ;
            end
            SPEraseFile([testCase.dirnam,'firmvalue_AMA_data.m' ]);
            SPEraseFile([testCase.dirnam,'firmvalue_AMA_matrices.m' ]);
            testCase.parnam='firmparms';   %name for parameter file
            testCase.modnam='firmvalue'; 
            testCase.OriginalPath=path;
            addpath(fullfile(pwd,'../'));
        end
    end
   methods (TestMethodTeardown)
       function restorePath(testCase)
           path(testCase.OriginalPath);
       end
   end
   
    
    methods (Test)
        
        function testFirmValueParse(testCase)
            [cof, scof, newCofb, param_, eqname_, endog_,...
                eqtype_, vtype_, neq, nlag, nlead, rts, lgrts,AMAcode]=...
                  SPSolve(testCase.dirnam,testCase.modnam,testCase.parnam);
                    testCase.verifyEqual(AMAcode,1,'AbsTol',eps);
        end
        function testFirmValueSolution(testCase)
            thePath=which('SPSolve');
            expPath='g:\git\SPSolve\SPSolve.m';
            testCase.verifyEqual(thePath,expPath);
        end
           
    end
    
end

