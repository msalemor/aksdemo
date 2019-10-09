using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repositories
{
    public interface IRepository<I,T>
    {
        IEnumerable<T> Get();
        T Get(I id);
    }
}
