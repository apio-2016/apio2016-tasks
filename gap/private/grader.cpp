#include <stdio.h>
#include <stdlib.h>

#include "gap.h"

static void my_assert(int k){ if (!k) exit(1); }

static const int grp_cnt = 4;
static int subtask_num, N;
static long long A[grp_cnt][100001];
static int sz[grp_cnt];
static long long call_count;

long long findGap(int, int);

void MinMax(long long s, long long t, long long *mn, long long *mx)
{
	my_assert(s <= t && mn != NULL && mx != NULL);
	int seen = 0;
	*mn = *mx = -1;
	for (int g=0;g<grp_cnt;g++) if (sz[g]){
		int lo = 1, hi = sz[g], left = sz[g]+1, right = 0;
		while (lo <= hi){
			int mid = (lo+hi)>>1;
			if (A[g][mid] >= s) hi = mid - 1, left = mid;
			else lo = mid + 1;
		}
		lo = 1, hi = sz[g];
		while (lo <= hi){
			int mid = (lo+hi)>>1;
			if (A[g][mid] <= t) lo = mid + 1, right = mid;
			else hi = mid - 1;
		}
		if (left <= right){
			if (!seen){
				*mn = A[g][left];
				*mx = A[g][right];
			}
			else{
				if (*mn > A[g][left]) *mn = A[g][left];
				if (*mx < A[g][right]) *mx = A[g][right];
			}
			seen += right - left + 1;
		}
	}
	if (subtask_num == 1) call_count++;
	else if (subtask_num == 2) call_count += seen + 1;
}

int main()
{
	FILE *in = fopen("__apio2016_gap_secret__.in", "r"), *out = fopen("__apio2016_gap_secret__.out", "w");
	my_assert(2 == fscanf(in, "%d%d", &subtask_num, &N));
	my_assert(1 <= subtask_num && subtask_num <= 2);
	my_assert(2 <= N && N <= 100000);
	long long a = 58283, b = N * 10, s = 128583;
	long long last = -1;
	for (int i=1;i<=N;i++){
		s = (s * a + b) % 1000000007;
		int g = s % grp_cnt;
		long long x;
		my_assert(1 == fscanf(in, "%lld", &x));
		my_assert(last < x);
		last = x;
		++sz[g];
		A[g][sz[g]] = x;
		s = (s + A[g][sz[g]]) % 1000000007;
	}
	my_assert(last <= 1000000000000000000ll);
	fprintf(out, "%lld\n", findGap(subtask_num, N));
	fprintf(out, "%lld\n", call_count);
}
