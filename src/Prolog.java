import java.util.ArrayList;
import java.util.HashMap;

import se.sics.jasper.Query;
import se.sics.jasper.SICStus;
import se.sics.jasper.SPException;

public class Prolog {
	
	private SICStus sp;
	
	public Prolog() throws SPException{
		this.sp = new SICStus();
	}
	
	public void load(String filePath) throws SPException{
		this.sp = new SICStus();
		sp.load(filePath);
	}
		
	public String demo(String queryS) throws NoSuchMethodException, InterruptedException, Exception{
		if (queryS != null && queryS.length() > 0 && queryS.charAt(queryS.length()-1)=='.') {
			queryS = queryS.substring(0, queryS.length()-1);
		}
		String demo = "demo("+queryS+",R).";
		HashMap map = new HashMap();
		Query query = sp.openPrologQuery(demo, map);
		StringBuilder output = new StringBuilder();
		if(query.nextSolution()){
			output.append(this.parseSolution(map.toString()));
		}
		while(query.nextSolution()){
			output.append("\n"+this.parseSolution(map.toString()));
		}
		return output.toString();
	}
	
	public String query(String queryS) throws NoSuchMethodException, InterruptedException, Exception{
		HashMap map = new HashMap();
		Query query = sp.openPrologQuery(queryS, map);
		StringBuilder output = new StringBuilder();
		if(query.nextSolution()){
			output.append(this.parseSolution(map.toString()));
		}
		while(query.nextSolution()){
			output.append("\n"+this.parseSolution(map.toString()));
		}
		return output.toString();
	}
	
	public String findAll(String template, String goal, int argc) throws NoSuchMethodException, InterruptedException, Exception{
		StringBuilder sb = new StringBuilder();
		String predicado = goal.substring(0, goal.indexOf('('));
		String solutions = this.query("findall("+template+","+goal+",L).");
		solutions = solutions.substring(solutions.indexOf('['), solutions.length()-1);
		if(solutions.equals("[]"))
			return "";
		
		solutions = solutions.substring(1,solutions.length()-1);
		
		ArrayList<String> p = new ArrayList<>();
		String[] split = solutions.split(",");

		for(int i = 0; i<split.length; i+=argc){
			if(!split[i].contains("_")){
				sb.append(predicado+"( ");
				for(int j = 0; j<argc; j++){
					sb.append(split[i+j]);
					if(argc-j > 1)
						sb.append(", ");
				}
				sb.append(" ).\n");
			}
		}
		return sb.toString();
	}

	private String parseSolution(String solution) {
		StringBuilder sb = new StringBuilder();
		Boolean end = false;
		for(int i = 0; !end; i++){
			char c = solution.charAt(i);
			switch(c){
			case '{': case ',':
				sb.append(c);
				i = parseTerm(solution,sb,i+1);
				break;
			case '}':
				if(sb.charAt(1) == ' '){
					sb.deleteCharAt(1);
				}
				if(sb.charAt(sb.length()-1) == ','){
					sb.deleteCharAt(sb.length()-1);
				}
				sb.append(c);
				end = true;
				break;
			default:
				i = parseTerm(solution,sb,i);
			}
		}
		return sb.toString();
	}
	
	private int parseTerm(String solution, StringBuilder sb, int index) {
		StringBuilder term = new StringBuilder();
		Boolean end = false;
		Boolean ignore = false;
		for(; !end; index++){
			char c = solution.charAt(index);
			switch(c){
			case '.':
				index = parseList(solution,term,index);
				break;
			case '_':
				ignore = true;
				break;
			case ',': 
				term.append(c);
				end = true;
				break;
			case '}':
				end = true;
				break;
			default:
				if(!ignore)
					term.append(c);
			}
		}
		if(!ignore){
			sb.append(term.toString());
		}
		if(term.length()>0){
			if(term.charAt(term.length()-1) == ',')
				return index-1;
			else
				return index-2;
		}
		else return index-2;
	}

	private  int parseList(String solution, StringBuilder sb, int index) {
		StringBuilder list = new StringBuilder();
		list.append('[');
		Boolean end = false;
		int nivel = 0;
		int hifen = 0;
		for(; !end; index++){
			char c = solution.charAt(index);
			switch(c){
			case '-':
				hifen++;
				break;
			case '.': case '[': case ']':
				break;
			case ',':
				if(hifen > 0){
					list.append('-');
					hifen--;
				}
				else list.append(',');
				break;
			case '(':
				nivel++;
				break;
			case ')':
				nivel--;
				if(nivel == 0) 
					end = true;
				break;
			default:
				list.append(c);
				break;			
			}
		}
		if(list.charAt(list.length()-1) == ','){
			list.deleteCharAt(list.length()-1);
		}
		list.append(']');
		sb.append(list.toString());
		return index-1;
	}

}
