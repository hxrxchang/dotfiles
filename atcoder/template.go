package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"

	"golang.org/x/exp/constraints"
)

const BUFSIZE = 10000000
var rdr *bufio.Reader

func main() {
	rdr = bufio.NewReaderSize(os.Stdin, BUFSIZE)
	solve()
}

func solve() {

}

// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

func pow(x, y int) int {
	return int(math.Pow(float64(x), float64(y)))
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
func newSet[V comparable]() map[V]struct{} {
	return make(map[V]struct{})
}

// heap (priority queue)
// 1.21 以上になったら comp.Ordered に変更する
type Heap[T constraints.Ordered] []T
func (h Heap[T]) len() int {
	return len(h)
}
func (h Heap[T]) less(i, j int) bool {
	return h[i] < h[j]
}
func (h Heap[T]) swap(i, j int) {
	h[i], h[j] = h[j], h[i]
}
func (h *Heap[T]) push(x T) {
	*h = append(*h, x)
}
func (h *Heap[T]) pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

// queue
type Queue[T any] struct {
	values []T
}
func newQueue[T any]() *Queue[T] {
	return &Queue[T]{}
}
func (q *Queue[T]) push(v T) {
	q.values = append(q.values, v)
}
func (q *Queue[T]) popLeft() T {
	v := q.values[0]
	q.values = q.values[1:]
	return v
}
func (q *Queue[T]) pop() T {
	v := q.values[len(q.values)-1]
	q.values = q.values[:len(q.values)-1]
	return v
}
func (q *Queue[T]) front() T {
	return q.values[0]
}
func (q *Queue[T]) size() int {
	return len(q.values)
}
func (q *Queue[T]) empty() bool {
	return len(q.values) == 0
}

