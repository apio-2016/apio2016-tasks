unit graderlib;

interface
    procedure MinMax(s, t: Int64; var mn, mx: Int64);

implementation
    uses gap;

    const
        MAX_N = 100005;
    var
        subtask_num: Integer;
        N: LongInt;
        V: array[0..MAX_N] of Int64;
        B: array[0..MAX_N] of Int64;
        A: array[0..MAX_N] of Int64;

        i: LongInt;
        answer, call_count: Int64;
        
        fin, fout: text;

    procedure MinMax(s, t: Int64; var mn, mx: Int64);
    var
        lo, hi, left, right, mid: LongInt;
    begin
		if (s > t) then halt;
        lo := 1;
        hi := N;
        left := N+1;
        right := 0;
        
        while (lo <= hi) do
        begin
            mid := (lo+hi) div 2;
            if (A[mid] >= s) then
            begin
                hi := mid - 1;
                left := mid;
            end
            else
                lo := mid + 1;
        end;

        lo := 1;
        hi := N;
        while (lo <= hi) do
        begin
            mid := (lo+hi) div 2;
            if (A[mid] <= t) then
            begin
                lo := mid + 1;
                right := mid;
            end
            else
                hi := mid - 1;
        end;

        if (left > right) then
        begin
            mn := -1;
            mx := -1;
        end
        else
        begin
            mn := A[left];
            mx := A[right];
        end;

        if (subtask_num = 1) then
            call_count += 1
        else
            call_count += right-left+2;
    end;

begin
    assign(fin, '__apio2016_gap_secret__.in');
    assign(fout, '__apio2016_gap_secret__.out');
    rewrite(fout);
    close(fout);
    reset(fin);
    Read(fin, subtask_num);
    Read(fin, N);
    for i := 1 to N do
        Read(fin, A[i]);
    close(fin);
    
    answer := findGap(subtask_num, N);

    rewrite(fout);
    WriteLn(fout, answer);
    WriteLn(fout, call_count);
    close(fout);
end.
