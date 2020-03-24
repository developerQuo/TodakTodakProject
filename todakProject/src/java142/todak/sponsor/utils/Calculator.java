package java142.todak.sponsor.utils;

public class Calculator {

	public static String calDigitNum(String num){

		String numS = num;
		int quotient = numS.length() / 3;
		int remainder = numS.length() % 3;
		StringBuffer numSB = new StringBuffer(numS);
		int balancer = 0;
		for (int i=0; i<quotient; i++){
			if ((i*3)+i+remainder == 0) {
				balancer = -1;
				continue;
			}
			numSB.insert((i*3)+i+balancer, ",");
		}
		
		return numSB.toString();
	}
}
