#include "tyrant.h"

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>

void *tyrant_alloc(size_t size)
{
	if (size == 0) {
		return NULL;
	}

	return malloc(size);
}

void *tyrant_calloc(size_t len, size_t size)
{
	if (len == 0 || size == 0) {
		return NULL;
	}

	// multiplication wrapping checked by calloc
	return calloc(len, size);
}

void *tyrant_alloc_arr(size_t len, size_t size)
{
	if (SIZE_MAX / len < size) {
		return NULL;
	}

	return tyrant_alloc(len * size);
}

void *tyrant_realloc(void *ptr, size_t size, bool *ret_success)
{
	if (size == 0) {
		*ret_success = false;
		return ptr;
	}

	void *ptr_new = realloc(ptr, size);
	if (ptr_new == NULL) {
		*ret_success = false;
		return ptr;
	}

	*ret_success = true;
	return ptr_new;
}

void *tyrant_realloc_arr(void *ptr, size_t len, size_t size, bool *ret_success)
{
	if (SIZE_MAX / len < size) {
		*ret_success = false;
		return ptr;
	}

	return tyrant_realloc(ptr, len * size, ret_success);
}

void tyrant_free(void *ptr)
{
	free(ptr);
}
