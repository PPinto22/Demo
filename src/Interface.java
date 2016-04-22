import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.filechooser.FileNameExtensionFilter;

import se.sics.jasper.SPException;

import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.ScrollPaneConstants;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.util.ArrayList;
import java.awt.Cursor;
import javax.swing.JScrollPane;
import javax.swing.JMenu;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class Interface extends JFrame {

	private JPanel contentPane;
	private JTextField textField;
	private JTextArea textArea;
	private JScrollPane scrollPane;
	private JMenuBar menuBar;
	private JMenu mnNewMenu;
	private JMenuItem mntmCarregarFicheiro;
	
	private Prolog prolog;
	private Historico historico;
	private static final String ficheiro = System.getProperty("user.dir")+"\\instituicao.pl";
	private JMenu mnDados;
	private JMenuItem mntmNewMenuItem;
	private JMenuItem mntmNewMenuItem_1;
	private JMenuItem mntmConsultas;
	private JMenuItem mntmProfissionais;

	
	private void start() {
		this.historico = new Historico(10);
		try{
			this.prolog = new Prolog();
		}
		catch(SPException e){
			textArea.append("Erro de inicialização do Prolog\n");
			return;
		}
		try{
			prolog.load(ficheiro);
			textArea.append("Ficheiro carregado: \""+ficheiro+"\"\n");
		}
		catch(SPException e){
			textArea.append("Impossível abrir o ficheiro \""+ficheiro+"\"\n");
		}
	}

	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Interface frame = new Interface();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	
	@Override
	public void setVisible(boolean value) {
	    super.setVisible(value);
	    textField.requestFocusInWindow();
	}

	public Interface() {
		setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
		setTitle("Demo");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 600, 350);
		
		menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		
		mnNewMenu = new JMenu("Ficheiro");
		menuBar.add(mnNewMenu);
		
		mntmCarregarFicheiro = new JMenuItem("Carregar ficheiro");
		mntmCarregarFicheiro.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				JFileChooser chooser = new JFileChooser();
			    FileNameExtensionFilter filter = new FileNameExtensionFilter(
			        "Ficheiros prolog (.pl)", "pl");
			    chooser.setFileFilter(filter);
			    int returnVal = chooser.showOpenDialog(null);
			    if(returnVal == JFileChooser.APPROVE_OPTION) {
			    	String path = chooser.getSelectedFile().getPath();
			    	try{
						prolog.load(path);
						textArea.append("Ficheiro carregado: \""+path+"\"\n");
					}
					catch(SPException exception){
						textArea.append("Impossível abrir o ficheiro \""+path+"\"\n");
					}
			    }
			}
		});
		mnNewMenu.add(mntmCarregarFicheiro);
		
		mnDados = new JMenu("Dados");
		menuBar.add(mnDados);
		
		mntmNewMenuItem = new JMenuItem("Utentes");
		mntmNewMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					textArea.append("> utentes (#IdUt,Nome,Idade,Morada)\n");
					String utentesPos = prolog.findAll("utente","(Id,N,I,M)","utente(Id,N,I,M)",4);
					String utentesNeg = prolog.findAll("-utente","(Id,N,I,M)","-utente(Id,N,I,M)",4);
					textArea.append(utentesPos);
					textArea.append(utentesNeg+"\n");
				} catch (Exception e1) {
					textArea.append("Erro\n");
				}
				
			}
		});
		mnDados.add(mntmNewMenuItem);
		
		mntmNewMenuItem_1 = new JMenuItem("Servicos");
		mntmNewMenuItem_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					textArea.append("> servicos (#Serv,Descricao,Instituicao,Cidade)\n");
					String servicosPos = prolog.findAll("servico","(S,D,I,C)","servico(S,D,I,C)",4);
					String servicosNeg = prolog.findAll("-servico","(S,D,I,C)","-servico(S,D,I,C)",4);
					textArea.append(servicosPos);
					textArea.append(servicosNeg+"\n");
				} catch (Exception e1) {
					textArea.append("Erro\n");
				}
			}
		});
		mnDados.add(mntmNewMenuItem_1);
		
		mntmConsultas = new JMenuItem("Consultas");
		mntmConsultas.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					textArea.append("> consultas (Data,#IdUt,#Serv,Custo)\n");
					String consultasPos = prolog.findAll("consulta","(D,U,S,C)","consulta(D,U,S,C)",4);
					String consultasNeg = prolog.findAll("-consulta","(D,U,S,C)","-consulta(D,U,S,C)",4);
					textArea.append(consultasPos);
					textArea.append(consultasNeg+"\n");
				} catch (Exception e1) {
					textArea.append("Erro\n");
				}
			}
		});
		mnDados.add(mntmConsultas);
		
		mntmProfissionais = new JMenuItem("Profissionais");
		mntmProfissionais.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					textArea.append("> profissionais (#IdProf,Nome,#Serv,Anos-Servico )\n");
					String profPos = prolog.findAll("profissional","(Id,N,S,A)","profissional(Id,N,S,A)",4);
					String profNeg = prolog.findAll("-profissional","(Id,N,S,A)","-profissional(Id,N,S,A)",4);
					textArea.append(profPos);
					textArea.append(profNeg+"\n");
				} catch (Exception e1) {
					textArea.append("Erro\n");
				}
			}
		});
		mnDados.add(mntmProfissionais);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		
		textArea = new JTextArea();
		textArea.setEditable(false);
		contentPane.add(textArea, BorderLayout.CENTER);
		
		JScrollPane scroll = new JScrollPane ( textArea );
	    scroll.setVerticalScrollBarPolicy ( ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS );
	    contentPane.add ( scroll );
		
		textField = new JTextField();
		textField.addKeyListener(new KeyAdapter() {
			@Override
			public void keyPressed(KeyEvent e) {
				if(e.getKeyCode() == e.VK_ENTER){
					textArea.append("> "+textField.getText()+"\n");
					historico.reset();
					if(!textField.getText().equals("")){
						historico.add(textField.getText());
						try{
							String resposta = prolog.demo(textField.getText());
							textArea.append(resposta+"\n");
						}
						catch(Exception exception){
							textArea.append("Erro\n");
						}
					}
					textField.setText(null);
				}
				else if(e.getKeyCode() == e.VK_UP){
					historico.up();
					textField.setText(historico.get());
				}
				else if(e.getKeyCode() == e.VK_DOWN){
					historico.down();
					textField.setText(historico.get());
				}
			}
		});
		contentPane.add(textField, BorderLayout.SOUTH);
		textField.setColumns(10);
		
		this.start();
	}

}
