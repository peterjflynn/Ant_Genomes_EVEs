
# coding: utf-8

# In[1]:

import pandas as pd
import numpy as np
import sys


# In[ ]:


hits_file = sys.argv[1]
ordered_hits_file = sys.argv[2]


# In[2]:


df = pd.read_table(hits_file, delim_whitespace=True, names=('qseqid', 'sseqid', 'pident', 'length', 'mismatch', 'gapopen', 'qstart', 'qend', 'sstart', 'send', 'evalue', 'bitscore'
))


# In[3]:


df1 = df.drop(['qseqid','pident', 'length', 'mismatch', 'gapopen', 'qstart', 'qend','evalue', 'bitscore'], 1)


# In[4]:


df2 = df1.sort_values(['sseqid', 'sstart'], ascending=[True, True])


# In[5]:


df_play = [df2['sstart'] > df2['send']]


# In[6]:


df2["send"], df2["sstart"] = np.where(df2['send'] < df2['sstart'],  [df2["sstart"], df2["send"]], [df2["send"], df2["sstart"] ])


# In[7]:


df2[0:10]


# In[8]:


df3 = df2.sort_values(['sseqid', 'send'], ascending=[True, True])


# In[9]:


df3[0:10]


# In[10]:


df3.to_csv(ordered_hits_file, sep ="\t", index= False, header= False)

