project(hellolib C)

set(hellolib_INCS hellolib.h)
set(hellolib_SRCS hellolib.c)

add_library(hellolib ${hellolib_SRCS})

# INSTALL Target
INSTALL(TARGETS hellolib
        # .exe, .dll
        RUNTIME DESTINATION bin COMPONENT Runtime
        # .so, .sl, ...
        LIBRARY DESTINATION lib COMPONENT Runtime
        # .a, .lib
        ARCHIVE DESTINATION lib COMPONENT Develop
)
INSTALL(FILES
	${hellolib_INCS}
	DESTINATION include
	COMPONENT Develop
)
