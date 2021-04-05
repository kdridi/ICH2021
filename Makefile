SRC			=	$(wildcard src/*.hs)
TARGET		=	ich

all			:	$(TARGET)

$(TARGET)	:	$(SRC)
			stack build
			cp $(shell stack path --local-install-root)/bin/$(TARGET) .

clean		:
			$(RM) $(TARGET)

fclean		:	clean
			$(RM) -r .stack-work

re			:	fclean all