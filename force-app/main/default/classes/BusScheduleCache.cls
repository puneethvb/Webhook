public with sharing class BusScheduleCache {

	private Cache.orgPartition part;
	public BusScheduleCache()
	{
		this.part = new Cache.orgPartition('local.BusSchedule');
		if(this.part==null)
		System.debug('null has been recovered');
	}

	public void putSchedule(String busLine, Time[] schedule)
	{
		this.part.put(busLine,schedule);

	}

	public List<Time> getSchedule(String busLine)
	{
		List<Time> schedule = (List<Time>)this.part.get(busLine);
		if(schedule==null)
		{
			schedule = new List<Time>();
			schedule.add(Time.newInstance(8,0,0,0));
			schedule.add(Time.newInstance(17,0,0,0));
		}

		System.debug(schedule);

		return schedule;

	}
}