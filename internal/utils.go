package internal

func MapKeys[T ~map[K]V, K comparable, V any](m T) []K {
	res := make([]K, 0, len(m))
	for k, _ := range m {
		res = append(res, k)
	}
	return res
}
