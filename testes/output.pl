:- meta_predicate
      out_tofile(0,+),             % out_tofile(:,+) in older versions
      out_ontofile(0,+),           % idem
      out_tostream__andclose(0,+). % idem

out_tofile(Goal, File) :-
   open(File,write,Stream),
   out_tostream__andclose(Goal, Stream).

out_ontofile(Goal, File) :-
   open(File,append,Stream),
   out_tostream__andclose(Goal, Stream).

out_tostream__andclose(Goal, Stream) :-
   current_output(Stream0),
   call_cleanup((set_output(Stream),once(Goal)), set_output_close(Stream0, Stream)).

set_output_close(Stream0, Stream) :-
   set_output(Stream0),
   close(Stream).
