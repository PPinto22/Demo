import java.util.ArrayList;

public class Historico {
	
	private ArrayList<String> historico;
	private int index;
	private int size;

	public Historico(int size){
		this.historico = new ArrayList<>(size);
		this.index = -1;
		this.size = size;
	}
	
	public void add(String s){
		if(this.historico.size() == size){
			this.historico.remove(size-1);
		}
		this.historico.add(0,s);
	}
	
	public void up(){
		this.index++;
		if(index >= historico.size()) index = historico.size()-1;
	}
	
	public void down(){
		this.index--;
		if(index < -1) index = -1;
	}
	
	public String get(){
		String ret = null;
		if(index > -1) ret = this.historico.get(index);
		return ret;
	}
	
	public void reset(){
		this.index = -1;
	}
}
