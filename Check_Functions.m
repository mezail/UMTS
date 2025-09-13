function Check_Functions()
%
% ������� ��������� �������� ������������ ���������������� ����� ��������

% ������� ������
    clc;

% ������� ����������� ���� ��������� ����������
    Dir = dir;
    Flag_Find1 = false;
    Flag_Find2 = false;
    for k = 1:length(Dir)
        if isequal(Dir(k).name, 'Common') && (Dir(k).isdir)
            Flag_Find1 = true;
        end
        if isequal(Dir(k).name, 'Main') && (Dir(k).isdir)
            Flag_Find2 = true;
        end
    end
    
    if ~(Flag_Find1 && Flag_Find2)
        disp('������ ������������ Check_Functions:')
        disp(['� ���������� ����������� ��������� ���������� ', ...
            'Common � Main!']);
        return
    end
    
    path([cd, '\Common'], path);
    path([cd, '\Main'], path);
    
% ������������� ������ ����������� �������    
    ListString = { ...
        '1. Generate_Primary_Synchronisation_Code'; ...
        '2. Generate_Secondary_Synchronisation_Codes'; ...
        '3. Generate_Scrambling_Groups_Table'; ...
        '4. Generate_Channelisation_Code'; ...
        '5. Generate_Scrambling_Code'; ...
        '6. Check_CRC'; ...
        '7. Convolutional_Decoder'; ...
        '8. First_DeInterleaver'; ...
        '9. Second_DeInterleaver'; ...
        '0. Matched_Filter'};

% ����� ������� ������ ����������� �������    
    [Selection, Flag_isOk] = listdlg(...
        'PromptString', 'Select a checked function name:', ...
        'SelectionMode', 'single', ...
        'ListSize', [300, 200], ...
        'ListString', ListString);

    if ~Flag_isOk
        return
    end

% �������� �������� ������    
    try
        load('Source_For_Check_Functions', 'Test');
    catch
        disp('������ ������� Check_Functions:');
        disp('����������� ��� �������� ���� Source_For_Check_Functions!');
        return
    end

switch ListString{Selection, 1}
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case '1. Generate_Primary_Synchronisation_Code'
        disp('�������� ������� Generate_Primary_Synchronisation_Code...');
        % ������� ������� �������
            try
                PSC = Generate_Primary_Synchronisation_Code;
            catch Error
                disp('  ������ ���������� �������:');
                display(getReport(Error));
                return
            end
        % �������� �����������
            Flag_isOk = true;
            if Flag_isOk
                if ~isa(PSC, 'double')
                Flag_isOk = false;
                end
            end
            if Flag_isOk
                if ~isequal(PSC, ...
                        Test.Generate_Primary_Synchronisation_Code.PSC)
                    Flag_isOk = false;
                end
            end
            if ~Flag_isOk
                disp('  ��������� �� ������!');
                return
            end
            disp('  ��������� ������!');
        
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
    case '2. Generate_Secondary_Synchronisation_Codes'
        disp(['�������� ������� ', ...
            'Generate_Secondary_Synchronisation_Codes...']);
        % ������� ������� �������
            try
                SSC = Generate_Secondary_Synchronisation_Codes;
            catch Error
                disp('  ������ ���������� �������:');
                display(getReport(Error));
                return
            end
        % �������� �����������
            Flag_isOk = true;
            if Flag_isOk
                if ~isa(SSC, 'double')
                Flag_isOk = false;
                end
            end
            if Flag_isOk
                if ~isequal(SSC, ...
                        Test.Generate_Secondary_Synchronisation_Codes.SSC)
                    Flag_isOk = false;
                end
            end
            if ~Flag_isOk
                disp('  ��������� �� ������!');
                return
            end
            disp('  ��������� ������!');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case '3. Generate_Scrambling_Groups_Table'
        disp('�������� ������� Generate_Scrambling_Groups_Table...');
        % ������� ������� �������
            try
                SG = Generate_Scrambling_Groups_Table;
            catch Error
                disp('  ������ ���������� �������:');
                display(getReport(Error));
                return
            end
        % �������� �����������
            Flag_isOk = true;
            if Flag_isOk
                if ~isa(SG, 'double')
                Flag_isOk = false;
                end
            end
            if Flag_isOk
                if ~isequal(SG, ...
                        Test.Generate_Scrambling_Groups_Table.SG)
                    Flag_isOk = false;
                end
            end
            if ~Flag_isOk
                disp('  ��������� �� ������!');
                return
            end
            disp('  ��������� ������!');
            
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case '4. Generate_Channelisation_Code'
        disp('�������� ������� Generate_Channelisation_Code...');
        % �������� ������������ ����������
            SF = 256;
        % ���� �� ������� �������������������
            for k = 0:255
                % ������� ������� �������
                    try
                        Ch = Generate_Channelisation_Code(SF, k);
                    catch Error
                        disp('  ������ ���������� �������:');
                        display(getReport(Error));
                        return
                    end
                % �������� �����������
                    Flag_isOk = true;
                    if Flag_isOk
                        if ~isa(Ch, 'double')
                            Flag_isOk = false;
                        end
                    end
                    if Flag_isOk
                        if ~isequal(Ch, ...
                                Test.Generate_Channelisation_Code.Ch( ...
                                k+1, :))
                            Flag_isOk = false;
                        end
                    end
                    if ~Flag_isOk
                        disp('  ��������� �� ������!');
                        return
                    end
            end
        disp('  ��������� ������!');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case '5. Generate_Scrambling_Code'
        disp('�������� ������� Generate_Scrambling_Code...');
        % ���� �� ������� �������������������        
            for k = 1:length(Test.Generate_Scrambling_Code.ns)
                % ������� ������� �������
                    try
                        Sn = Generate_Scrambling_Code( ...
                            Test.Generate_Scrambling_Code.ns(1, k));
                    catch Error
                        disp('  ������ ���������� �������:');
                        display(getReport(Error));
                        return
                    end
                % �������� �����������
                    Flag_isOk = true;
                    if Flag_isOk
                        if ~isa(Sn, 'double')
                            Flag_isOk = false;
                        end
                    end
                    if Flag_isOk
                        if ~isequal(Sn, ...
                                Test.Generate_Scrambling_Code.Sn(k, :))
                            Flag_isOk = false;
                        end
                    end
                    if ~Flag_isOk
                        disp('  ��������� �� ������!');
                        return
                    end
            end
        disp('  ��������� ������!');
        
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case '6. Check_CRC'
        disp('�������� ������� Check_CRC...');
        % ������� ������� �������
            try
                [Z_Flag_isOk, Data] = Check_CRC(Test.Check_CRC.InVect, ...
                    Test.Check_CRC.CRC_Size);
            catch Error
                disp('  ������ ���������� �������:');
                display(getReport(Error));
                return
            end
        % �������� �����������
            Flag_isOk = true;
            if Flag_isOk
                if ~((isa(Z_Flag_isOk, 'double') || ...
                        isa(Z_Flag_isOk, 'logical')) && ...
                        isa(Data, 'double'))
                    Flag_isOk = false;
                end
            end
            if Flag_isOk
                if ~(isequal(Z_Flag_isOk, Test.Check_CRC.Flag_isOk) && ...
                        isequal(Data, Test.Check_CRC.Data))
                    Flag_isOk = false;
                end
            end
            if ~Flag_isOk
                disp('  ��������� �� ������!');
                return
            end
        disp('  ��������� ������!');
        
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case '7. Convolutional_Decoder'
        disp('�������� ������� Convolutional_Decoder...');
        % ������� ������� �������
            try
                Decoded_Vect = Convolutional_Decoder( ...
                    Test.Convolutional_Decoder.Coded_Vect, ...
                    Test.Convolutional_Decoder.Flag_isHalf);
            catch Error
                disp('  ������ ���������� �������:');
                display(getReport(Error));
                return
            end
        % �������� �����������
            Flag_isOk = true;
            if Flag_isOk
                if ~isa(Decoded_Vect, 'double')
                    Flag_isOk = false;
                end
            end
            if Flag_isOk
                if ~isequal(Decoded_Vect, ...
                        Test.Convolutional_Decoder.Decoded_Vect)
                    Flag_isOk = false;
                end
            end
            if ~Flag_isOk
                disp('  ��������� �� ������!');
                return
            end
        disp('  ��������� ������!');
        
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case '8. First_DeInterleaver'
        disp('�������� ������� First_DeInterleaver...');
        % ���� �� ��������� TTI
            for k = 1:length(Test.First_DeInterleaver.TTI)
                % ������� ������� �������
                    try
                        Deinterleaved_Vect = First_DeInterleaver( ...
                            Test.First_DeInterleaver.Interleaved_Vect{ ...
                            k, 1}, Test.First_DeInterleaver.TTI(1, k));
                    catch Error
                        disp('  ������ ���������� �������:');
                        display(getReport(Error));
                        return
                    end
                % �������� �����������
                    Flag_isOk = true;
                    if Flag_isOk
                        if ~isa(Deinterleaved_Vect, 'double')
                            Flag_isOk = false;
                        end
                    end
                    if Flag_isOk
                        if ~isequal(Deinterleaved_Vect, ...
                                Test.First_DeInterleaver. ...
                                Deinterleaved_Vect{k, 1})
                            Flag_isOk = false;
                        end
                    end
                    if ~Flag_isOk
                        disp('  ��������� �� ������!');
                        return
                    end
            end
        disp('  ��������� ������!');
        
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case '9. Second_DeInterleaver'
        disp('�������� ������� Second_DeInterleaver...');
        % ������� ������� �������
            try
                Deinterleaved_Vect = Second_DeInterleaver( ...
                    Test.Second_DeInterleaver.Interleaved_Vect);
            catch Error
                disp('  ������ ���������� �������:');
                display(getReport(Error));
                return
            end
        % �������� �����������
            Flag_isOk = true;
            if Flag_isOk
                if ~isa(Deinterleaved_Vect, 'double')
                    Flag_isOk = false;
                end
            end
            if Flag_isOk
                if ~isequal(Deinterleaved_Vect, ...
                        Test.Second_DeInterleaver.Deinterleaved_Vect)
                    Flag_isOk = false;
                end
            end
            if ~Flag_isOk
                disp('  ��������� �� ������!');
                return
            end
        disp('  ��������� ������!');
        
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case '0. Matched_Filter'
        disp('�������� ������� Matched_Filter...');
        % ���� �� ���������� �������� �������� � �������� ��������� �������
            for k = 1:2
                % ������� ������� �������
                    try
                        FSignal = Matched_Filter( ...
                            Test.Matched_Filter.Signal{k, 1}, ...
                            Test.Matched_Filter.df{k, 1});
                    catch Error
                        disp('  ������ ���������� �������:');
                        display(getReport(Error));
                        return
                    end
                % �������� �����������
                    Flag_isOk = true;
                    if Flag_isOk
                        if ~isa(FSignal, 'double')
                            Flag_isOk = false;
                        end
                    end
                    if Flag_isOk
                        if mean(abs(FSignal - ...
                                Test.Matched_Filter.FSignal{k, 1})) > ...
                                10^(-10)
                            Flag_isOk = false;
                        end
                    end
                    if ~Flag_isOk
                        disp('  ��������� �� ������!');
                        if isequal(k, 1)
                            disp('  ������ � ����������!');
                        else
                            disp('  ������ � ���������� �������!');
                        end
                        return
                    end
            end
        disp('  ��������� ������!');
        
end

% �������� �����
    rmpath([cd, '\Common']);
    rmpath([cd, '\Main']);