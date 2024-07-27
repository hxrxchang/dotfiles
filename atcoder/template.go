package main

import (
	"bufio"
	"container/heap"
	"fmt"
	"math"
	"math/big"
	"os"
	"sort"
	"strconv"
	"strings"

	"github.com/liyue201/gostl/ds/deque"
	"github.com/liyue201/gostl/ds/set"
	"github.com/liyue201/gostl/utils/comparator"
	"golang.org/x/exp/constraints"
	"golang.org/x/exp/maps"
)

const BUFSIZE = 10000000
const MOD = 1000000007
const BIGGEST = math.MaxInt64
var rdr *bufio.Reader

func main() {
	rdr = bufio.NewReaderSize(os.Stdin, BUFSIZE)
	solve()
}

func solve() {
}

// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

func getInt() int {
	return s2i(input())
}

func getInts() []int {
	return mapToIntSlice(input())
}

func getStr() string {
	return input()
}

func getStrs() []string {
	return strToSlice(input(), " ")
}

// 一行をstringで読み込み
func input() string {
	buf := make([]byte, 0, 16)
	for {
		l, p, e := rdr.ReadLine()
		if e != nil {
			fmt.Println(e.Error())
			panic(e)
		}
		buf = append(buf, l...)
		if !p {
			break
		}
	}
	return string(buf)
}

func getBigInt(x int) *big.Int {
	return big.NewInt(int64(x))
}

// string <-> []string
// 第２引数で渡された文字列でsplitする
func strToSlice(input, sep string) []string {
	return strings.Split(input, sep)
}


// // string <-> []int
func mapToIntSlice(input string) []int {
	slice := make([]int, 0)
	lines := strToSlice(input, " ")
	for _, v := range lines {
		// s2iはstringをintに変換する関数(後述)
		slice = append(slice, s2i(v))
	}
	return slice
}

// string <-> int
func s2i(s string) int {
	v, ok := strconv.Atoi(s)
	if ok != nil {
		panic("Faild : " + s + " can't convert to int")
	}
	return v
}

func i2s(i int) string {
	return strconv.Itoa(i)
}

// bool <-> int
func b2i(b bool) int {
	if b {
		return 1
	}
	return 0
}

func i2b(i int) bool {
  return i != 0
}

func abs(v int) int {
	if v < 0 {
		return -v
	}
	return v
}

func min(values ...int) int {
	ret := values[0]
	for _, v := range values {
		if ret > v {
			ret = v
		}
	}
	return ret
}

func max(values ...int) int {
	ret := values[0]
	for _, v := range values {
		if ret < v {
			ret = v
		}
	}
	return ret
}

func mod(x, y int) int {
	m := x % y
	if m < 0 {
		return m + y
	}
	return m
}

func pow(base, exp int) int {
	result := 1
	for exp > 0 {
		if exp%2 == 1 {
			result = (result * base)
		}
		base = (base * base)
		exp /= 2
	}
	return result
}

func modPow(base, exp, mod int) int {
	result := 1
	for exp > 0 {
		if exp%2 == 1 {
			result = (result * base) % mod
		}
		base = (base * base) % mod
		exp /= 2
	}
	return result
}

func gcd(v1, v2 int) int {
	if v1 > v2 {
		v1, v2 = v2, v1
	}
	for v1 != 0 {
		v1, v2 = v2%v1, v1
	}
	return v2
}

func lcm(v1, v2 int) int {
	return v1 * v2 / gcd(v1, v2)
}

func ceilDiv(a, b int) int {
	if a + b - 1 < 0 && (a + b - 1) % b != 0 {
		return (a + b - 1) / b - 1
	}
	return (a + b - 1) / b
}

// set
type Set[V comparable] struct {
	values map[V]struct{}
}
func newSet[V comparable]() *Set[V] {
	return &Set[V]{values: make(map[V]struct{})}
}
func (s *Set[V]) Add(v V) {
	s.values[v] = struct{}{}
}
func (s *Set[V]) Remove(v V) {
	delete(s.values, v)
}
func (s *Set[V]) Has(v V) bool {
	_, ok := s.values[v]
	return ok
}
func (s *Set[V]) Values() []V {
	return maps.Keys(s.values)
}

// sorted set
type SortedSet[T comparator.Ordered] struct {
	values *set.Set[T]
}
func newSortedSet[T comparator.Ordered]() *SortedSet[T] {
	var comparatorFn comparator.Comparator[T] = comparator.OrderedTypeCmp[T]
	return &SortedSet[T]{values: set.New[T](comparatorFn)}
}
func (s *SortedSet[T]) add(v T) {
	s.values.Insert(v)
}
func (s *SortedSet[T]) remove(v T) {
	s.values.Erase(v)
}
func (s *SortedSet[T]) has(v T) bool {
	return s.values.Contains(v)
}
func (s *SortedSet[T]) size() int {
	return s.values.Size()
}
func (s *SortedSet[T]) lowerBound(v T) *set.SetIterator[T] {
	return s.values.LowerBound(v)
}
func (s *SortedSet[T]) upperBound(v T) *set.SetIterator[T] {
	return s.values.UpperBound(v)
}

// multiset
func newMultiset[T comparator.Ordered]() *set.MultiSet[T] {
	var comparatorFn comparator.Comparator[T] = comparator.OrderedTypeCmp[T]
	return set.NewMultiSet[T](comparatorFn, set.WithGoroutineSafe())
}

// heap (priority queue)
// 1.21 以上になったら cmp.Ordered に変更する
type Heap[T constraints.Ordered] []T
func (h Heap[T]) Len() int {
	return len(h)
}
func (h Heap[T]) Less(i, j int) bool {
	return h[i] < h[j]
}
func (h Heap[T]) Swap(i, j int) {
	h[i], h[j] = h[j], h[i]
}
func (h *Heap[T]) Push(x any) {
	*h = append(*h, x.(T))
}
func (h *Heap[T]) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type MyHeap[T constraints.Ordered] struct {
	heap Heap[T]
}
func newMyHeap[T constraints.Ordered]() *MyHeap[T] {
	myHeap := &MyHeap[T]{}
	heap.Init(&myHeap.heap)
	return myHeap
}
func (h *MyHeap[T]) push(x T) {
	heap.Push(&h.heap, x)
}
func (h *MyHeap[T]) pop() T {
	return heap.Pop(&h.heap).(T)
}
func (h *MyHeap[T]) len() int {
	return h.heap.Len()
}

func sortSlice[T constraints.Ordered](slice []T) []T {
    copiedSlice := make([]T, len(slice))
    copy(copiedSlice, slice)

    sort.Slice(copiedSlice, func(i, j int) bool {
        return copiedSlice[i] < copiedSlice[j]
    })

    return copiedSlice
}

func reverse[T any](slice []T) []T {
	copiedSlice := make([]T, len(slice))
	copy(copiedSlice, slice)

	for i, j := 0, len(copiedSlice)-1; i < j; i, j = i+1, j-1 {
		copiedSlice[i], copiedSlice[j] = copiedSlice[j], copiedSlice[i]
	}
	return copiedSlice
}

// 1.22 になったら slice.Contains を使用する
func sliceContains[T comparable](slice []T, v T) bool {
	for _, e := range slice {
		if e == v {
			return true
		}
	}
	return false
}

// 0~n-1までのスライスを作成
func rangeSlice(n int) []int {
	slice := make([]int, n)
	for i := 0; i < n; i++ {
		slice[i] = i
	}
	return slice
}

// 開区間でstart~endまでのスライスを作成
func rangeSlice2(start, end int) []int {
	slice := make([]int, end - start + 1)
	for i := start; i <= end; i++ {
		slice[i - start] = i
	}
	return slice
}

// 2次元スライスのコピー
func copy2DSlice(original [][]int) [][]int {
    newSlice := make([][]int, len(original))
    for i := range original {
        newSlice[i] = make([]int, len(original[i]))
        copy(newSlice[i], original[i])
    }
    return newSlice
}

// スライスを文字列に変換
func sliceToStr[T any](data []T, separator string) string {
	var strSlice []string
    for _, v := range data {
        strSlice = append(strSlice, fmt.Sprintf("%v", v))
    }
    return strings.Join(strSlice, separator)
}

// queue
func newQueue[T any]() *deque.Deque[T] {
	return deque.New[T]()
}


// UnionFind
type UnionFind struct {
	// parentsは要素が正の値のときはそのインデックスのルートを表す。
	// 負の値のときはそのインデックスはルートであり絶対値がそのルートが持つ要素数を表す。
	parents []int
}
func (uf *UnionFind) root(x int) int {
	if uf.parents[x] < 0 {
		return x
	}
	uf.parents[x] = uf.root(uf.parents[x])
	return uf.parents[x]
}
func (uf *UnionFind) unit(x, y int) {
	x = uf.root(x)
	y = uf.root(y)
	if x == y {
		return
	}
	// x, yはルートなので必ず負の値(そのルートがもつ要素数)になる
	if uf.parents[x] > uf.parents[y] {
		x, y = y, x
	}
	// ルートの要素数を更新
	uf.parents[x] += uf.parents[y]
	// サイズが小さい方のルートを大きい方のルートに繋げる
	uf.parents[y] = x
}
func (uf *UnionFind) isSame(x, y int) bool {
	return uf.root(x) == uf.root(y)
}
func (uf *UnionFind) size(x int) int {
	return -uf.parents[uf.root(x)]
}
func newUnionFind(n int) *UnionFind {
	parents := make([]int, n)
	for i := 0; i < n; i++ {
		parents[i] = -1
	}
	return &UnionFind{parents: parents}
}

// algorithm
// 約数列挙
func getDividors(n int) []int {
	ret := make([]int, 0)
	for i := 1; i*i <= n; i++ {
		if n%i == 0 {
			ret = append(ret, i)
			if i*i != n {
				ret = append(ret, n/i)
			}
		}
	}
	return sortSlice(ret)
}

// 順列列挙
// 与えられたスライスの次の順列を取得する
// 使用例
// x := []int{1, 2, 3, 4}
// for {
// 	fmt.Println(x)
// 	if !NextPermutation(sort.IntSlice(x)) {
// 		break
// 	}
// }
func nextPermutation(x sort.Interface) bool {
	n := x.Len() - 1
	if n < 1 {
		return false
	}
	j := n - 1
	for ; !x.Less(j, j+1); j-- {
		if j == 0 {
			return false
		}
	}
	l := n
	for !x.Less(j, l) {
		l--
	}
	x.Swap(j, l)
	for k, l := j+1, n; k < l; {
		x.Swap(k, l)
		k++
		l--
	}
	return true
}

// 組み合わせ
// スライスからk個選ぶ組み合わせを列挙
func getCombinations(list []int, k int) [][]int {
	res := make([][]int, 0)
	combs := getCombinationsCh(list, k)
	for comb := range combs {
		res = append(res, comb)
	}
	return res
}
func getCombinationsCh(list []int, k int) (c chan []int) {
	c = make(chan []int, 2)
	n := len(list)

	pattern := make([]int, k)

	var body func(pos, begin int)
	body = func(pos, begin int) {
		if pos == k {
			t := make([]int, k)
			copy(t, pattern)
			c <- t
			return
		}

		for num := begin; num < n+pos-k+1; num++ {
			pattern[pos] = list[num]
			body(pos+1, num+1)
		}
	}
	go func() {
		defer close(c)
		body(0, 0)
	}()

	return
}

// nCr
func getComb(n, k int) int {
	numerator := 1
	denominator := 1
	for i := 0; i < k; i++ {
		numerator *= n - i
		denominator *= i + 1
	}
	return numerator / denominator
}

// n以下の素数を列挙
func primeNumbers(n int) []int {
	isPrime := make([]bool, n+1)
	for i := 0; i <= n; i++ {
		isPrime[i] = true
	}
	isPrime[0] = false
	isPrime[1] = false

	for i := 2; i <= n; i++ {
		if isPrime[i] {
			for j := i * 2; j <= n; j += i {
				isPrime[j] = false
			}
		}
	}

	primes := make([]int, 0)
	for i, b := range isPrime {
		if b {
			primes = append(primes, i)
		}
	}

	return primes
}

// bit全探索
func generateSubsets[T any](elements []T) [][]T {
	n := len(elements)
	totalCombinations := 1 << n
	subsets := make([][]T, totalCombinations)

	for i := 0; i < totalCombinations; i++ {
		var subset []T
		for j := 0; j < n; j++ {
			if i&(1<<j) != 0 {
				subset = append(subset, elements[j])
			}
		}
		subsets[i] = subset
	}

	return subsets
}

// binary search
func bisect[T constraints.Ordered](slice []T, fn func(int) bool) int {
	return sort.Search(len(slice), fn)
}
// sliceの中でvalue以上の値が最初に現れるindexを返す
func bisectLeft[T constraints.Ordered](slice []T, value T) int {
	return bisect(slice, func(i int) bool { return slice[i] >= value })
}
// sliceの中でvalueより大きい値が最初に現れるindexを返す
func bisectRight[T constraints.Ordered](slice []T, value T) int {
	return bisect(slice, func(i int) bool { return slice[i] > value })
}

// Segment Tree
type SegmentTree[T any] struct {
	data []T
	n    int // 葉の数(全区間の要素数)
	e    T // 単位元
	op   func(T, T) T
}

func NewSegmentTree[T any](n int, e T, op func(T, T) T) *SegmentTree[T] {
	segtree := &SegmentTree[T]{}
	segtree.e = e
	segtree.op = op
	segtree.n = 1
	for segtree.n < n {
		segtree.n *= 2
	}
	segtree.data = make([]T, segtree.n*2-1)
	for i := 0; i < segtree.n*2-1; i++ {
		segtree.data[i] = segtree.e
	}
	return segtree
}

func (segtree *SegmentTree[T]) Update(idx int, x T) {
	idx += segtree.n - 1
	segtree.data[idx] = x
	for 0 < idx {
		idx = (idx - 1) / 2
		segtree.data[idx] = segtree.op(segtree.data[idx*2+1], segtree.data[idx*2+2])
	}
}

func (segtree *SegmentTree[T]) query(begin, end, idx, a, b int) T {
	if b <= begin || end <= a {
		return segtree.e
	}
	if begin <= a && b <= end {
		return segtree.data[idx]
	}
	v1 := segtree.query(begin, end, idx*2+1, a, (a+b)/2)
	v2 := segtree.query(begin, end, idx*2+2, (a+b)/2, b)
	return segtree.op(v1, v2)
}
// endは閉区間であることに注意
func (segtree *SegmentTree[T]) Query(begin, end int) T {
	return segtree.query(begin, end, 0, 0, segtree.n)
}


// sliceを一行で出力
func printSlice[T any](data []T) {
	fmt.Println(strings.Trim(fmt.Sprint(data), "[]"))
}

// 部分文字列判定
// 非連続の部分文字列も対応
// isSubstring("abcd", "ad") -> true
func isSubstring(s, t string) bool {
	ok := false
	iter := 0
	for i := 0; i < len(s); i++ {
		if s[i] == t[iter] {
			iter++
		}
		if iter == len(t) {
			ok = true
			break
		}
	}
	return ok
}
