.SILENT:
.PHONY: all clean current doc doc-srv serve tox


all:
	echo ""
	echo "Development utilities"
	echo "  clean        Removes all temporary files"
	echo "  current      Runs the tox-environment for the current development"
	echo "  doc          Builds the documentation using 'Sphinx'"
	echo "  doc-srv      Serves the documentation on port 8082 (and automatically builds it)"
	echo "  serve        Runs the Django development server on port 8080"
	echo "  tox          Runs complete tox test environment"
	echo ""
	echo "Docker related commands"
	echo "  Please note, that if you are not 'root', you have to do 'sudo make ...'!"
	echo ""
	echo "  docker/test-build-context"
	echo "      Builds a minimal docker container and shows the context"
	echo "      This is used to check the .dockerignore file"
	echo ""


# deletes all temporary files created by Django
clean:
	find . -iname "*.pyc" -delete
	find . -iname "__pycache__" -delete

current:
	tox -q -e util

doc:
	tox -q -e doc

doc-srv: doc
	tox -q -e doc-srv

serve:
	tox -q -e run

tox:
	tox -q

docker/test-build-context:
	echo " \
		FROM busybox\n \
		COPY . /build-context\n \
		WORKDIR /build-context\n \
		CMD find ." \
	| docker build -t test-build-context -f- . \
	&& docker container run --rm test-build-context
