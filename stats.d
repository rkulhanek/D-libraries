import std.range, std.algorithm, std.conv, std.math;
import std.stdio;

real mean(T)(T[] x) {
	return x.sum.to!real / x.length;
}

real variance(T)(T[] x) {
	auto a = x.map!(a => a * a).sum.to!real / x.length;
	auto b = mean(x);
	return a - b * b;
}

real stdev(T)(T[] x) {
	return sqrt(variance(x));
}

real welch_t_test(T)(T[] x1, T[] x2) {
	real bessel(T)(T[] x) {
		real n = x.length.to!real;
		return n / (n - 1.0);
	}

	auto mean1 = mean(x1);
	auto mean2 = mean(x2);
	//prefer unbiased variance, since that should make false positives less likely.
	auto var1 = variance(x1) * bessel(x1);
	auto var2 = variance(x2) * bessel(x2);
	auto n1 = x1.length.to!real;
	auto n2 = x2.length.to!real;

	auto num = mean1 - mean2;
	auto den = sqrt(var1 / n1 + var2 / n2);
	auto t = num / den;

	num = var1 / n1 + var2 / n2;
	num *= num;

	den = (var1 * var1) / (n1 * n1 * (n1 - 1))
		+ (var2 * var2) / (n2 * n2 * (n2 - 1 ));

	auto df = num / den;

	stderr.writef("t = %.8f\ndf = %.8f\n", t, df);
	return t;
}

real[T] distribution(T)(T[] data) {
	real[T] counts;
	foreach (x; data) counts[x]++;
	foreach (ref x; counts) x /= data.length;
	return counts;
}

real KL(T)(real[T] p, real[T] q) {
	//pre: p.keys == q.keys
	real sum = 0.0;
//	writef("p: %s\nq: %s\n", p, q);
	ulong q_seen = 0;
	foreach (k; p.keys) {
		if (k in q) q_seen++;
		if (p[k] == 0.0) continue;//lim_{x->0} x log x = 0
		assert(k in q);
		sum += p[k] * log2(q[k] / p[k]);
	}
	if (q_seen != q.length) {
		auto P = p.keys.sort;
		auto Q = q.keys.sort;
		stderr.writef("p: %s\nq: %s\n", P, Q);
		assert(q_seen == q.length, "q contains some key not in p");
	}
	return -1.0 * sum;
}

