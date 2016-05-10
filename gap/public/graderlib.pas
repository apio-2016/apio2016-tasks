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
        A: array[0..MAX_N] of Int64;

		i: LongInt;
		answer, call_count: Int64;

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
    Read(subtask_num);
    Read(N);
    for i := 1 to N do
        Read(A[i]);
	
	answer := findGap(subtask_num, N);

	WriteLn(answer);
	WriteLn(call_count);
end.
