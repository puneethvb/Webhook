public without sharing class VacationRequestSchedule implements Schedulable
{
	public Interface VacationRequest
	{
		void execute(SchedulableContext sc);
	}

	public void execute(SchedulableContext sc)
	{
		Type t = Type.forName('VacationRequestActual');
		if(t!=null)
		{
			VacationRequest vc = (VacationRequest)t.newInstance();
			vc.execute(sc);
		}

	}
}