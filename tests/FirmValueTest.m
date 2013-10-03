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
        
        function testFirmValueSPSolve(testCase)
            SPEraseFile([testCase.dirnam,'firmvalue_AMA_data.m' ]);
            SPEraseFile([testCase.dirnam,'firmvalue_AMA_matrices.m' ]);
            
            [cofTst, scofTst, newCofbTst, param_Tst, eqname_Tst, endog_Tst,...
                eqtype_Tst, vtype_Tst, neqTst, nlagTst, nleadTst, rtsTst, lgrtsTst,AMAcodeTst]=...
                SPSolve(testCase.dirnam,testCase.modnam,testCase.parnam);
            testCase.verifyEqual(AMAcodeTst,1,'AbsTol',eps);
        end
        function testFirmValueParse(testCase)
            SPEraseFile([testCase.dirnam,'firmvalue_AMA_data.m' ]);
            SPEraseFile([testCase.dirnam,'firmvalue_AMA_matrices.m' ]);
            
            [parserRetCodeTst,...
                param_Tst,npTst,modnameTst,neqTst,nlagTst,nleadTst,eqname_Tst,eqtype_Tst,endog_Tst,delay_Tst,vtype_Tst]=...
                SPParser(testCase.dirnam,testCase.modnam);
            testCase.verifyEqual(parserRetCodeTst,0,'AbsTol',eps);
        end
        function testFirmValueCof(testCase)
            eval(testCase.parnam)
            eval([testCase.modnam,'_AMA_matrices']);
            [rh,ch] = size(cofh);
            [rg,cg] = size(cofg);
            cofTst = zeros(rh,ch);
            cofTst(1:rg,1:cg) = cofg;
            cofTst = cofTst + cofh;
            load firmValueTest.mat;
            testCase.verifyEqual(cofTst,cof,'AbsTol',eps);
        end
        function testSPAmalg(testCase)
                       load firmValueTest.mat;
            [cofbTst,rtsTst,iaTst,nexTst,nnumTst,lgrtsTst,AMAcode] = SPAmalg(cof,neq,nlag,nlead,1.0e-8,1+1.0e-8);
           testCase.verifyEqual(cofbTst,newCofb,'AbsTol',eps);
        end
        function testSPSolvePath(testCase)
            thePath=which('SPSolve');
            expPath='g:\git\SPSolve\SPSolve.m';
            testCase.verifyEqual(thePath,expPath);
        end
        function testObstruct(testCase)
            load firmValueTest.mat;
            scofTst = SPObstruct(cof,newCofb,neq,nlag,nlead);
            testCase.verifyEqual(scofTst,scof,'AbsTol',eps);
        end
        
    end
    
end

