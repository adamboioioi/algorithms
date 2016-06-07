	# v. 0.0.1
	require 'tsort'

	read_graph_from_file = ARGV[0].nil? ? "govern.in" : ARGV[0]
	output_file = ARGV[1].nil? ? "govern.out" : ARGV[1]

	input_data = File.open(read_graph_from_file)
	g = {}
	input_data.readlines.each do |line|
		start_vertex, end_vertex = *line.split
		g.has_key?(start_vertex) ? g[start_vertex] << end_vertex : g[start_vertex] = [end_vertex]
	end

	each_node = lambda {|&b| g.each_key(&b) }
	each_child = lambda {|n, &b| return unless g.has_key?(n); g[n].each(&b) }
	TSort.tsort_each(each_node, each_child) {|v| File.open(output_file, 'a') { |f| f.write("#{v}\n") }}