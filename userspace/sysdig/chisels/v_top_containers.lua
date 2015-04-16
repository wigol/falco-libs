--[[
Copyright (C) 2013-2014 Draios inc.
 
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License version 2 as
published by the Free Software Foundation.


This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]

view_info = 
{
	id = "top_containers",
	name = "Top Containers",
	description = "List all the containers running on this machine, and the resources that each of them uses.",
	tips = {"Select a container and click enter to drill down into it. At that point, you will be able to access several views that will show you the details of the selected container."},
--	tags = {"Containers"},
	view_type = "table",
	applies_to = "all",
	filter = "container.name != host",
	use_defaults = true,
	drilldown_target = "LD_top_cont_procs",
	columns = 
	{
		{
			name = "NA",
			field = "proc.pid",
			is_key = true
		},
		{
			name = "CPU",
			field = "proc.cpu",
			description = "Amount of CPU used by the container.",
			colsize = 8,
			aggregation = "AVG",
			groupby_aggregation = "SUM",
			is_sorting = true
		},
		{
			name = "PROCS",
			field = "evt.count",
			description = "Number of processes currently running inside the container.",
			groupby_aggregation = "SUM",
			colsize = 8,
		},
		{
			name = "THREADS",
			field = "proc.nthreads",
			description = "Number of threads currently running inside the container.",
			groupby_aggregation = "SUM",
			colsize = 5
		},
		{
			name = "VIRT",
			field = "proc.vmsize",
			groupby_aggregation = "SUM",
			colsize = 9
		},
		{
			name = "RES",
			field = "proc.vmrss",
			groupby_aggregation = "SUM",
			colsize = 9
		},
		{
			name = "FILE",
			field = "evt.buflen.file",
			description = "Total (input+output) file I/O bytes generated by the container during the sampling interval. On trace files, this is the sum for the whole file.",
			colsize = 8,
			aggregation = "SUM",
			groupby_aggregation = "SUM"
		},
		{
			name = "NET",
			field = "evt.buflen.net",
			description = "Total (input+output) network I/O bytes generated by the container during the sampling interval. On trace files, this is the sum for the whole file.",
			colsize = 8,
			aggregation = "SUM",
			groupby_aggregation = "SUM"
		},
		{
			name = "ID",
			field = "container.id",
			description = "ID of the container. The format depends on the container technology.",
			is_groupby_key = true
		},
		{
			name = "Container",
			field = "container.name",
			description = "Name of the container.",
			colsize = 15
		},
	}
}
