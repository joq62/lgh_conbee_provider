all:
	rm -rf  *~ */*~ src/*.beam test/*.beam test_ebin erl_cra*;
	rm -rf *.dir;
	rm -rf _build;
	rm -rf logs;
	rm -rf ebin
	rm -rf rebar.lock;
	rebar3 compile;
	mkdir ebin;
	cp _build/default/lib/*/ebin/* ebin;
	rm -rf _build*;
	git add -f *;
	git commit -m $(m);
	git push;
	echo Ok there you go!
build:
	rm -rf  *~ */*~ src/*.beam test/*.beam test_ebin erl_cra*;
	rm -rf *.dir;
	rm -rf _build;
	rm -rf ebin
	rm -rf rebar.lock;
#	mkdir ebin;		
	rebar3 compile;
	mkdir ebin;
	cp _build/default/lib/*/ebin/* ebin;
	rm -rf _build*;
	rm -rf ebin;
	rm -rf  test_ebin;
clean:
	rm -rf  *~ */*~ src/*.beam test/*.beam test_ebin erl_cra*;
	rm -rf *.dir;
	rm -rf _build;
	rm -rf ebin
	rm -rf logs;
	rm -rf rebar.lock
lgh_test:
	rm -rf test_ebin;
	mkdir test_ebin;
	erlc -o test_ebin test/*.erl;
	erl -pa test_ebin -sname lgh_test -setcookie a -run lgh_test start

eunit:
#	Standard
	rm -rf  *~ */*~ src/*.beam test/*.beam test_ebin erl_cra*;
	rm -rf *.dir;
	rm -rf _build;
	rm -rf ebin
	rm -rf logs;
	rm -rf rebar.lock
#	Application speciic
#	test
	mkdir test_ebin;
	cp test/*.app test_ebin;
	erlc -I include -I /home/joq62/erlang/include -o test_ebin test/*.erl;
#	compile
	rebar3 compile;
	mkdir ebin;
	cp _build/default/lib/*/ebin/* ebin;
	rm -rf _build*;
#	Application specific
	erl -pa ebin -pa test_ebin\
	    -sname do_test\
	    -run $(m) start\
	    -setcookie test_cookie
