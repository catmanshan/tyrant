#ifndef tyrant_h
#define tyrant_h

#include <stddef.h>
#include <stdbool.h>

#define TYRANT_ALLOC_ARR(ptr, len) \
	tyrant_alloc_arr((len), sizeof((ptr)[0]))

#define TYRANT_REALLOC_ARR(ptr, len, ret_success) \
	tyrant_realloc_arr((ptr), (len), sizeof((ptr)[0]), (ret_success))

void *tyrant_alloc(size_t size);
void *tyrant_calloc(size_t len, size_t size);
void *tyrant_alloc_arr(size_t len, size_t size);
void *tyrant_realloc(void *ptr, size_t size, bool *ret_success);
void *tyrant_realloc_arr(void *ptr, size_t len, size_t size,
		bool *ret_success);
void tyrant_free(void *ptr);

#endif //  tyrant_h
