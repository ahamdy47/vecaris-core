#VECARIS [1.6] core assembler (.vcs)

import sys
import re

labels = {}

def parselabels(fn):
    linenum = 0
    with open(sys.argv[1]) as f:
        for line in f:
            line = line.replace('\n', '').replace('\r', '')
            if line[0]=='/':
            	if line[1]=='/':
                	continue
            if line[0]==':':
                labels[line[1:]] = linenum
                print("Label: " + line[1:] + " @ " + format(linenum, '#02x'))
            else:
                linenum = linenum + 1

def zerobin(fn):
    with open(fn, "wb") as binary_file:
        binary_file.close()

def writebin(fn, b):
    with open(fn, "a") as binary_file:
        binary_file.write(b)

print("\n[vc-asm]")
print("Assembler for the VECARIS [1.6] core (vcore)\n")
if len(sys.argv) != 2:
    print("file format: vc-asm filename.vcs")
    sys.exit()

else:
    print(".vcs file found "  + sys.argv[1] + " -> i.mem")

zerobin("i.mem")

parselabels(sys.argv[1])

with open(sys.argv[1]) as f:
	linenum = 0
	for line in f:
		linenum = linenum + 1

		# Ignore labels
		if line[0]==':':
			continue

		# Ignore comments
		if line[0]=='/':
			if line[1]=='/':
				continue

		line = line.replace('\n', '').replace('\r', '')
		tok = re.split(r'[: ]',line)

		if '' in tok:
			tok.remove('')

		print("tok str: " + str(tok))

		if tok[0].upper() == "ADD" or tok[0].upper() == "SUB" or tok[0].upper() == "NOT" or tok[0].upper() == "SL" or tok[0].upper() == "SR" or tok[0].upper() == "AND" or tok[0].upper() == "OR" or tok[0].upper() == "ZLE":
			if(len(tok)<4):
				print("Invalid argument size")
				print("line: " + str(linenum))
				sys.exit()
			if(tok[1].isdigit() or tok[1][0:2] == "0x" or tok[1][0:2] == "0X"):
				r1 = int(tok[1], 0)
				if r1 >= 0 and r1 < 16:
					if(tok[2].isdigit() or tok[2][0:2] == "0x" or tok[2][0:2] == "0X"):
						r2 = int(tok[2], 0)
						if r2 >= 0 and r2 < 16:
							if(tok[3].isdigit() or tok[3][0:2] == "0x" or tok[3][0:2] == "0X"):
								r3 = int(tok[3], 0)	
								if r3 >= 0 and r3 < 16:
									r1Str = str(hex(r1))
									r1Str = r1Str[2:]
									r2Str = str(hex(r2))
									r2Str = r2Str[2:]
									r3Str = str(hex(r3))
									r3Str = r3Str[2:]
									
								else:
									print("Invalid register")
									print("line: " + str(linenum))
									sys.exit()
							else:
								print("Invalid register")
								print("line: " + str(linenum))
								sys.exit()
						else:
							print("Invalid register")
							print("line: " + str(linenum))
							sys.exit()
					else:
						print("Invalid register")
						print("line: " + str(linenum))
						sys.exit()
				else:
					print("Invalid register")
					print("line: " + str(linenum))
					sys.exit()
			else:
				print("Invalid register")
				print("line: " + str(linenum))
				sys.exit()

			if(tok[0].upper() == "ADD"):
				writebin("i.mem", "1")
			elif(tok[0].upper() == "SUB"):
				writebin("i.mem", "2")
			elif(tok[0].upper() == "NOT"):
				writebin("i.mem", "3")
			elif(tok[0].upper() == "SL"):
				writebin("i.mem", "4")
			elif(tok[0].upper() == "SR"):
				writebin("i.mem", "5")
			elif(tok[0].upper() == "AND"):
				writebin("i.mem", "6")
			elif(tok[0].upper() == "OR"):
				writebin("i.mem", "7")
			elif(tok[0].upper() == "ZLE"):
				writebin("i.mem", "8")
			writebin("i.mem", r1Str)
			writebin("i.mem", r2Str)
			writebin("i.mem", r3Str)
			writebin("i.mem", "\n")

		elif tok[0].upper() == "ST" or tok[0].upper() == "LD" or tok[0].upper() == "LDI" or tok[0].upper() == "PRT" :
			if(len(tok)<3):
				print("Invalid argument size")
				print("line: " + str(linenum))
				sys.exit()
			if(tok[1].isdigit() or tok[1][0:2] == "0x" or tok[1][0:2] == "0X"):
				r = int(tok[1], 0)
				if r >= 0 and r <= 15:
					rStr = str(hex(r))
					rStr = rStr[2:]
					if(tok[2].isdigit() or tok[2][0:2] == "0x" or tok[2][0:2] == "0X"):
						addr = int(tok[2],0)
						addrStr = str(hex(addr))
						addrStr = addrStr[2:]
						if(addr<256):
							if(addr<16):
								addrStr = '0' + addrStr
							
						else:
							print("Invalid memory address")
							print("line: " + str(linenum))
							sys.exit()
					else:
						print("Invalid memory address")
						print("line: " + str(linenum))
						sys.exit()
				else:
					print("Invalid register")
					print("line: " + str(linenum))
					sys.exit()
			else:
				print("Invalid register")
				print("line: " + str(linenum))
				sys.exit()
			if(tok[0].upper() == "ST"):
				writebin("i.mem", "9")
			elif(tok[0].upper() == "LD"):
				writebin("i.mem", "a")
			elif(tok[0].upper() == "LDI"):
				writebin("i.mem", "b")
			elif(tok[0].upper() == "PRT"):
				writebin("i.mem", "e")
			writebin("i.mem", rStr)
			writebin("i.mem", addrStr)
			writebin("i.mem", "\n")

		elif tok[0].upper() == "BZ" or tok[0].upper() == "J":
			if(len(tok)<2):
				print("Invalid argument size")
				print("line: " + str(linenum))
				sys.exit()
			if tok[1] in labels:
				addr = labels[tok[1]]
			elif(tok[1].isdigit() or tok[1][0:2] == "0x" or tok[1][0:2] == "0X"):
				addr = int(tok[1],0)				
			else:
				print("Undefined label")
				print("line: " + str(linenum))
				sys.exit()
			addrStr = str(hex(addr))
			addrStr = addrStr[2:]
			if(addr<4096):
				if(addr<256):
					addrStr = '0' + addrStr
					if(addr<16):
						addrStr = '0' + addrStr
			else:
				print("Invalid address")
				print("line: " + str(linenum))
				sys.exit()
			if(tok[0].upper() == "BZ"):
				writebin("i.mem", "c")
			elif(tok[0].upper() == "J"):
				writebin("i.mem", "d")
			writebin("i.mem", addrStr)
			writebin("i.mem", "\n")
		
		elif tok[0].upper() == "HALT":
				writebin("i.mem", "0000")
		
		else:
			print("Unknown operand")
			print("line: " + str(linenum))
			sys.exit()

print("assembler: i.mem hex file generated")