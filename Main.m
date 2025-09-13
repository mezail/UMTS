% ������� ������������ ������ � Command Window
    clc;
    clear all;
    close all;
    
% ���������� �����
    path([cd, '\Signals'], path);
    path([cd, '\Common'], path);
    path([cd, '\Main'], path);
    
% �������� ������� Signal � ������� �������    
    % Beeline Megafon Megafon5 Megafon99 Megafon99_01 MTS   
    load('Megafon99'); % � �������� ����������� ��� ����� ��
        % �������� ����� ������� ������ �������
         
% ������������� ���������� �������    
    df = 0; % ���� ��� ��� ��������� ������� ������ �������� ��������� 
            % ���������
    FSignal = Matched_Filter(Signal, 0);
    
% �������� ������������� - ����� ������� ������� (��)
    Slots_Offsets = Slot_Synchronization(FSignal, true);
% ��� ������ ��������� �� �������� ��������� ��������� ���������
    if ~isempty(Slots_Offsets)
        % �������� ���������� ��� �������� ������������ ������ ������������
        % ������ ��������� ��
            BCCHs = cell(length(Slots_Offsets), 1);
        for k = 1:1 %length(Slots_Offsets) % ��� ������ ��
            % �������� �������������    
                [Frame_Offset, SG] = Frame_Synchronization(FSignal, ...
                    Slots_Offsets(1, k), true);
            % ����������� ������ �������������� ������������������    
                SC_Num = Scrambling_Code_Determination(FSignal, ...
                    Frame_Offset, SG, true);
            % ���������� rake-�������
                Rake_Pattern = Rake_Pattern_Calculation(Signal, ...
                    FSignal, Frame_Offset, SC_Num, true);
            % ����������� ������������ ������
                PCCPCH_Bits = One_Ray_PCCPCH_Demodulation(Signal, ...
                    Rake_Pattern, Frame_Offset, SC_Num, true);
            % ������������� ������������ ������ ������������ ������
                [Flag_isOk, BCCH] = Decode_BCCH(PCCPCH_Bits);
                display(Flag_isOk);
            % ���������� ���������� ������
                BCCHs{k, 1} = BCCH;
        end
    end
    
% �������� �����
%     rmpath([cd, '\Signals']);
%     rmpath([cd, '\Common']);
%     rmpath([cd, '\Main']);